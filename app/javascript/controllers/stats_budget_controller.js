import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="stats-budget"
export default class extends Controller {
  static targets = ["savings", "dailyLimit"];
  static values = { savings: Number, dailyLimit: Number, currency: String };

  connect() {
    this.savingsTarget.textContent = 0;
    this.dailyLimitTarget.textContent = 0;
    this.countUp(this.savingsTarget, this.savingsValue);
    this.countUp(this.dailyLimitTarget, this.dailyLimitValue);
  }

  format(value) {
    return new Intl.NumberFormat("en", {
      style: "currency",
      currency: this.currencyValue,
    }).format(value);
  }

  countUp(target, finalValue) {
    const steps = 60;
    const duration = 1000;
    const interval = duration / steps;
    const increment = finalValue / steps;
    let current = 0;

    const timer = setInterval(() => {
      current += increment;
      if (current >= finalValue) {
        target.textContent = this.format(finalValue);
        clearInterval(timer);
      } else {
        target.textContent = this.format(current);
      }
    }, interval);
  }
}
