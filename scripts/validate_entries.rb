#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "yaml"

ROOT = File.expand_path("..", __dir__)
ENTRY_DIR = File.join(ROOT, "_research")
PROJECT_DIR = File.join(ROOT, "_projects")

REQUIRED_ENTRY_FIELDS = %w[
  title id record_id project core_activity activity_type status result summary tax_year
  started ended duration_days research_hours research_hours_basis investigators tags example evidence
].freeze

REQUIRED_CORE_HEADINGS = [
  "Research question",
  "Intended new knowledge",
  "Existing knowledge",
  "Technical uncertainty",
  "Competent professional assessment",
  "Hypothesis",
  "Experiment design",
  "Variables and controls",
  "Work performed",
  "Observations",
  "Evaluation",
  "Logical conclusion",
  "Supporting activities"
].freeze

REQUIRED_SUPPORTING_HEADINGS = [
  "Supporting activity",
  "Related core activity",
  "Direct relationship",
  "Work performed",
  "Production or exclusion assessment",
  "Dominant purpose assessment",
  "Records retained",
  "Conclusion"
].freeze

VALID_STATUSES = %w[planned running concluded abandoned].freeze
VALID_RESULTS = %w[pending supported rejected inconclusive not-applicable].freeze
VALID_ACTIVITY_TYPES = %w[core supporting].freeze
VALID_RESEARCH_HOURS_BASES = %w[recorded estimated].freeze

def parse_document(path)
  raw = File.read(path)
  match = raw.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  raise "missing YAML front matter" unless match

  data = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true) || {}
  [data.transform_keys(&:to_s), raw[match.end(0)..]]
end

def parse_date(value)
  Date.parse(value.to_s)
rescue Date::Error
  nil
end

errors = []
ids = {}

projects = Dir.glob(File.join(PROJECT_DIR, "*.{md,markdown}"), File::FNM_EXTGLOB).to_h do |path|
  begin
    data, = parse_document(path)
    slug = data["slug"] || File.basename(path, File.extname(path))
    %w[title id record_id slug summary status tax_year started ended field_of_research core_activities benefit].each do |field|
      value = data[field]
      errors << "#{path}: required project field '#{field}' is missing" if value.nil? || value.respond_to?(:empty?) && value.empty?
    end
    benefit = data["benefit"] || {}
    %w[effective_ownership control financial_burden].each do |field|
      errors << "#{path}: project benefit.#{field} is required" if benefit[field].to_s.strip.empty?
    end
    [slug, data]
  rescue StandardError => e
    errors << "#{path}: #{e.message}"
    [File.basename(path, File.extname(path)), {}]
  end
end

Dir.glob(File.join(ENTRY_DIR, "*.{md,markdown}"), File::FNM_EXTGLOB).sort.each do |path|
  begin
    data, body = parse_document(path)
    label = data["id"] || File.basename(path)

    REQUIRED_ENTRY_FIELDS.each do |field|
      value = data[field]
      errors << "#{label}: required field '#{field}' is missing" if value.nil? || value.respond_to?(:empty?) && value.empty?
    end

    if data["id"] && !data["id"].match?(/\ARD-\d{4}-\d{3,}\z/)
      errors << "#{label}: id must match RD-YYYY-NNN"
    end
    if data["record_id"] != data["id"]
      errors << "#{label}: record_id must match id"
    end
    if ids.key?(data["id"])
      errors << "#{label}: duplicate id also used by #{ids[data['id']]}"
    else
      ids[data["id"]] = path
    end

    errors << "#{label}: unknown project '#{data['project']}'" unless projects.key?(data["project"])
    errors << "#{label}: invalid status '#{data['status']}'" unless VALID_STATUSES.include?(data["status"])
    errors << "#{label}: invalid result '#{data['result']}'" unless VALID_RESULTS.include?(data["result"])
    unless VALID_ACTIVITY_TYPES.include?(data["activity_type"])
      errors << "#{label}: invalid activity_type '#{data['activity_type']}'"
    end

    started = parse_date(data["started"])
    ended = parse_date(data["ended"])
    record_field = data["activity_type"] == "supporting" ? "purpose_recorded" : "hypothesis_recorded"
    record_date = parse_date(data[record_field])
    errors << "#{label}: started is not a valid date" unless started
    errors << "#{label}: ended is not a valid date" unless ended
    errors << "#{label}: #{record_field} is not a valid date/time" unless record_date
    errors << "#{label}: ended precedes started" if started && ended && ended < started
    if started && record_date && record_date > started
      errors << "#{label}: #{record_field} must be recorded no later than the activity start date"
    end

    if started && ended && data["duration_days"].to_i != (ended - started).to_i + 1
      errors << "#{label}: duration_days must equal the inclusive date window"
    end

    research_hours = data["research_hours"]
    unless research_hours.is_a?(Numeric) && research_hours.positive?
      errors << "#{label}: research_hours must be a positive number"
    end
    unless VALID_RESEARCH_HOURS_BASES.include?(data["research_hours_basis"])
      errors << "#{label}: research_hours_basis must be 'recorded' or 'estimated'"
    end

    if data["status"] == "concluded" && data["result"] == "pending"
      errors << "#{label}: a concluded entry cannot have a pending result"
    end

    required_headings = data["activity_type"] == "supporting" ? REQUIRED_SUPPORTING_HEADINGS : REQUIRED_CORE_HEADINGS
    required_headings.each do |heading|
      level = heading == "Variables and controls" ? "###" : "##"
      pattern = /^#{level}\s+#{Regexp.escape(heading)}\s*$/i
      errors << "#{label}: missing heading '#{heading}'" unless body.match?(pattern)
    end

    Array(data["evidence"]).each do |item|
      next unless item.is_a?(Hash) && item["url"].to_s.start_with?("/")

      evidence_path = File.join(ROOT, item["url"].sub(%r{\A/}, ""))
      errors << "#{label}: linked evidence does not exist: #{item['url']}" unless File.file?(evidence_path)
    end
  rescue StandardError => e
    errors << "#{path}: #{e.message}"
  end
end

if errors.empty?
  puts "Validated #{ids.length} research entries across #{projects.length} project(s)."
  exit 0
end

warn "Research record validation failed:\n\n"
errors.each { |error| warn "  - #{error}" }
warn "\n#{errors.length} error(s) found."
exit 1
