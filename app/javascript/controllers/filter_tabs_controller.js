import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "pill"]

  connect() {
    const active = this.tabTargets.find(tab => tab.classList.contains("active"))
    if (active) this.movePill(active)
  }

  select(event) {
    event.preventDefault()
    const href = event.currentTarget.href
    this.movePill(event.currentTarget)
    this.element.classList.add("popped")
    setTimeout(() => {
      Turbo.visit(href)
    }, 400)
  }

  movePill(tab) {
    this.pillTarget.style.transform = `translateX(${tab.offsetLeft}px) translateY(-50%)`
  }
}
