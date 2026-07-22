(() => {
  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  const navToggle = document.querySelector(".nav-toggle");
  const nav = document.querySelector(".site-nav");

  if (navToggle && nav) {
    navToggle.addEventListener("click", () => {
      const open = nav.classList.toggle("open");
      navToggle.setAttribute("aria-expanded", String(open));
    });
  }

  const cards = [...document.querySelectorAll("#research-grid .research-card")];
  const filterButtons = [...document.querySelectorAll("[data-filter]")];
  const searchInput = document.querySelector("#research-search");
  const resultCount = document.querySelector("#result-count");
  const emptyResults = document.querySelector("#empty-results");
  let selectedFilter = "all";

  const applyFilters = () => {
    const query = searchInput?.value.trim().toLowerCase() || "";
    let visible = 0;

    cards.forEach((card) => {
      const statusMatches = selectedFilter === "all" || card.dataset.status === selectedFilter;
      const textMatches = !query || card.dataset.search.includes(query);
      const show = statusMatches && textMatches;
      card.hidden = !show;
      visible += show ? 1 : 0;
    });

    if (resultCount) {
      resultCount.textContent = `Showing ${visible} experiment${visible === 1 ? "" : "s"}`;
    }
    if (emptyResults) emptyResults.hidden = visible !== 0;
  };

  filterButtons.forEach((button) => {
    button.addEventListener("click", () => {
      selectedFilter = button.dataset.filter;
      filterButtons.forEach((candidate) => candidate.classList.toggle("active", candidate === button));
      applyFilters();
    });
  });

  searchInput?.addEventListener("input", applyFilters);

  const sectionLinks = [...document.querySelectorAll(".entry-aside nav a")];
  if (sectionLinks.length && "IntersectionObserver" in window) {
    const targets = sectionLinks
      .map((link) => document.querySelector(link.getAttribute("href")))
      .filter(Boolean);
    const observer = new IntersectionObserver(
      (entries) => {
        const visibleEntry = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => a.boundingClientRect.top - b.boundingClientRect.top)[0];
        if (!visibleEntry) return;
        sectionLinks.forEach((link) => {
          link.classList.toggle("active", link.getAttribute("href") === `#${visibleEntry.target.id}`);
        });
      },
      { rootMargin: "-12% 0px -76% 0px", threshold: 0 }
    );
    targets.forEach((target) => observer.observe(target));
  }

  if (reduceMotion) return;

  const canvas = document.querySelector("#signal-field");
  if (!canvas) return;

  const context = canvas.getContext("2d");
  if (!context) return;

  let width = 0;
  let height = 0;
  let points = [];
  let animationFrame;

  const resize = () => {
    const pixelRatio = Math.min(window.devicePixelRatio || 1, 2);
    width = window.innerWidth;
    height = window.innerHeight;
    canvas.width = width * pixelRatio;
    canvas.height = height * pixelRatio;
    canvas.style.width = `${width}px`;
    canvas.style.height = `${height}px`;
    context.setTransform(pixelRatio, 0, 0, pixelRatio, 0, 0);

    const pointCount = Math.min(44, Math.max(18, Math.floor(width / 32)));
    points = Array.from({ length: pointCount }, () => ({
      x: Math.random() * width,
      y: Math.random() * height,
      vx: (Math.random() - 0.5) * 0.085,
      vy: (Math.random() - 0.5) * 0.085,
      radius: Math.random() * 0.75 + 0.35
    }));
  };

  const draw = () => {
    context.clearRect(0, 0, width, height);

    for (let index = 0; index < points.length; index += 1) {
      const point = points[index];
      point.x += point.vx;
      point.y += point.vy;

      if (point.x < -10) point.x = width + 10;
      if (point.x > width + 10) point.x = -10;
      if (point.y < -10) point.y = height + 10;
      if (point.y > height + 10) point.y = -10;

      context.beginPath();
      context.arc(point.x, point.y, point.radius, 0, Math.PI * 2);
      context.fillStyle = "rgba(121, 232, 226, 0.48)";
      context.fill();

      for (let otherIndex = index + 1; otherIndex < points.length; otherIndex += 1) {
        const other = points[otherIndex];
        const dx = point.x - other.x;
        const dy = point.y - other.y;
        const distance = Math.sqrt(dx * dx + dy * dy);
        if (distance < 145) {
          context.beginPath();
          context.moveTo(point.x, point.y);
          context.lineTo(other.x, other.y);
          context.strokeStyle = `rgba(126, 182, 205, ${(1 - distance / 145) * 0.13})`;
          context.lineWidth = 0.55;
          context.stroke();
        }
      }
    }

    animationFrame = window.requestAnimationFrame(draw);
  };

  resize();
  draw();

  let resizeTimer;
  window.addEventListener("resize", () => {
    window.clearTimeout(resizeTimer);
    resizeTimer = window.setTimeout(resize, 150);
  });

  document.addEventListener("visibilitychange", () => {
    if (document.hidden) {
      window.cancelAnimationFrame(animationFrame);
    } else {
      draw();
    }
  });
})();

