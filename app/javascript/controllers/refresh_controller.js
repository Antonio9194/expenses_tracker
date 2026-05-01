import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh"
export default class extends Controller {
  connect() {
    this.startY = 0
    this.pulling = false
    this.ready = false
    this.threshold = 80

    // Create the spinner element and add it to the page
    this.indicator = document.createElement("div")
    this.indicator.className = "ptr-indicator"
    this.indicator.innerHTML = `<div class="ptr-spinner"></div>`
    document.body.prepend(this.indicator)

    // Bind touch events manually (we need passive: false on touchmove
    // so we can call preventDefault and stop the page from scrolling while pulling)
    this.onStart = this.touchStart.bind(this)
    this.onMove  = this.touchMove.bind(this)
    this.onEnd   = this.touchEnd.bind(this)

    this.element.addEventListener("touchstart", this.onStart, { passive: true })
    this.element.addEventListener("touchmove",  this.onMove,  { passive: false })
    this.element.addEventListener("touchend",   this.onEnd)
  }

  disconnect() {
    // Clean up when controller is removed
    this.element.removeEventListener("touchstart", this.onStart)
    this.element.removeEventListener("touchmove",  this.onMove)
    this.element.removeEventListener("touchend",   this.onEnd)
    this.indicator?.remove()
  }

  touchStart(e) {
    // Only activate when already at the very top of the page
    if (window.scrollY === 0) {
      this.startY = e.touches[0].clientY
      this.pulling = true
    }
  }

  touchMove(e) {
    if (!this.pulling) return
    const distance = e.touches[0].clientY - this.startY
    if (distance > 0 && window.scrollY === 0) {
      e.preventDefault() // prevent normal scroll while pulling
      const pull = Math.min(distance * 0.5, this.threshold) // dampen movement
      this.indicator.style.transform = `translateX(-50%) translateY(${pull - 60}px)`
      this.indicator.style.opacity   = pull / this.threshold
      this.ready = pull >= this.threshold - 10
      this.indicator.classList.toggle("ptr-ready", this.ready)
    }
  }

  touchEnd() {
    if (!this.pulling) return
    this.pulling = false

    if (this.ready) {
      // Spin and refresh
      this.indicator.classList.add("ptr-refreshing")
      setTimeout(() => Turbo.visit(window.location.href), 400)
    } else {
      // Snap back
      this.indicator.style.transform = ""
      this.indicator.style.opacity   = "0"
      this.indicator.classList.remove("ptr-ready")
    }
    this.ready = false
  }
}
