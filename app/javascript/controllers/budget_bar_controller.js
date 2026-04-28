import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["fill"];
  static values = { percentage: Number };
  connect() {
    this.fillTarget.style.width = "0%";
    setTimeout(() => {
      this.fillTarget.style.width = `${this.percentageValue}%`;
    }, 50);
  }
}
