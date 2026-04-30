import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="stats-monthly"
export default class extends Controller {
  static targets = ["expensesSum", "subscriptionsSum"];
  static values = {
    expensesSum: Number,
    subscriptionsSum: Number,
    currency: String,
  };
  connect() {
    this.expensesSumTarget.textContent = 0;
    this.subscriptionsSumTarget.textContent = 0;
    this.countUp(this.expensesSumTarget, this.expensesSumValue);
    this.countUp(this.subscriptionsSumTarget, this.subscriptionsSumValue);
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
