import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="splash"
export default class extends Controller {
  static targets = ["top", "bottom"]

  connect() {
    if (sessionStorage.getItem("splashShown")) {
      this.topTarget.remove();
      this.bottomTarget.remove();
      return;
    }

    setTimeout(() => {
      this.topTarget.classList.add("splash-exit");
      this.bottomTarget.classList.add("splash-exit");
      setTimeout(() => {
        this.topTarget.remove();
        this.bottomTarget.remove();
        sessionStorage.setItem("splashShown", "true");
      }, 700);
    }, 1200);
  }
}
