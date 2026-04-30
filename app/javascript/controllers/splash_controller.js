import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="splash"
export default class extends Controller {
  static targets = ["overlay"]

  connect() {
    if (sessionStorage.getItem("splashShown")) {
      this.overlayTarget.remove();
      return;
    }

    setTimeout(() => {
      this.overlayTarget.classList.add("splash-exit");
      setTimeout(() => {
        this.overlayTarget.remove();
        sessionStorage.setItem("splashShown", "true");
      }, 600);
    }, 1200);
  }
}
