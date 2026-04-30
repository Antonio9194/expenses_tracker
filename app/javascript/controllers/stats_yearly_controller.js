import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="stats-yearly"
export default class extends Controller {
  static targets = ["expenses", "activeSubs", "combined"];
  static values = {
    expenses: Number,
    activeSubs: Number,
    combinedTotal: Number,
    currency: String,
  };

  connect() {
    this.expensesTarget.textContent = 0;
    this.activeSubsTarget.textContent = 0;
    this.combinedTarget.textContent = 0;
    this.countUp(this.expensesTarget, this.expensesValue);
    this.countUp(this.activeSubsTarget, this.activeSubsValue);
    this.countUp(this.combinedTarget, this.combinedTotalValue);
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
