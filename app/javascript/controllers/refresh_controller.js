import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="refresh"
export default class extends Controller {
  connect() {
    this.startY = 0;
    this.pulling = false;
    this.ready = false;
    this.threshold = 80;

    this.indicator = document.createElement("div");
    this.indicator.className = "ptr-indicator";
    this.indicator.innerHTML = `<div class="ptr-track"><div class="ptr-arc"></div></div>`;
    // Prepend to <html> so body transform doesn't affect it
    document.documentElement.prepend(this.indicator);

    this.onStart = this.touchStart.bind(this);
    this.onMove = this.touchMove.bind(this);
    this.onEnd = this.touchEnd.bind(this);

    this.element.addEventListener("touchstart", this.onStart, {
      passive: true,
    });
    this.element.addEventListener("touchmove", this.onMove, { passive: false });
    this.element.addEventListener("touchend", this.onEnd);
  }

  disconnect() {
    this.element.removeEventListener("touchstart", this.onStart);
    this.element.removeEventListener("touchmove", this.onMove);
    this.element.removeEventListener("touchend", this.onEnd);
    this.indicator?.remove();
  }

  touchStart(e) {
    if (window.scrollY === 0) {
      this.startY = e.touches[0].clientY;
      this.pulling = true;
    }
  }

  touchMove(e) {
    if (!this.pulling) return;
    const distance = e.touches[0].clientY - this.startY;
    if (distance > 0 && window.scrollY === 0) {
      e.preventDefault();
      const pull = Math.min(distance * 0.5, this.threshold);
      const progress = pull / this.threshold;

      // Slide indicator down
      this.indicator.style.transform = `translateX(-50%) translateY(${pull - 60}px)`;
      this.indicator.style.opacity = progress;

      // Pull page content down (elastic feel)
      this.element.style.transition = "none";
      this.element.style.transform = `translateY(${pull * 0.8}px)`;

      this.ready = pull >= this.threshold - 10;
      this.indicator.classList.toggle("ptr-ready", this.ready);
    }
  }

  touchEnd() {
    if (!this.pulling) return;
    this.pulling = false;

    // Spring page back
    this.element.style.transition =
      "transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1)";
    this.element.style.transform = "";

    if (this.ready) {
      this.indicator.classList.add("ptr-refreshing");
      setTimeout(() => {
        this.element.style.transition = "";
        this.element.style.transform = "";
        Turbo.visit(window.location.href);
      }, 500);
    } else {
      this.indicator.style.transition =
        "transform 0.3s ease, opacity 0.2s ease";
      this.indicator.style.transform = "translateX(-50%) translateY(-60px)";
      this.indicator.style.opacity = "0";
      setTimeout(() => {
        this.indicator.style.transition = "";
      }, 300);
      this.element.style.transition = "";
    }
    this.ready = false;
  }
}
