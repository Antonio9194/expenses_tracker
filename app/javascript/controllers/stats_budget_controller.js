import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="stats-budget"
export default class extends Controller {
  static targets = [
    "savings",
    "dailyLimit",
    "monthlyExpenses",
    "history",
    "monthlySubs",
  ];
  static values = {
    savings: Number,
    dailyLimit: Number,
    monthlyExpenses: Number,
    history: Number,
    monthlySubs: Number,
    currency: String,
  };

  connect() {
    if (this.hasSavingsTarget) {
      this.savingsTarget.textContent = 0;
      this.countUp(this.savingsTarget, this.savingsValue);
    }
    if (this.hasDailyLimitTarget) {
      this.dailyLimitTarget.textContent = 0;
      this.countUp(this.dailyLimitTarget, this.dailyLimitValue);
    }
    if (this.hasMonthlyExpensesTarget) {
      this.monthlyExpensesTarget.textContent = 0;
      this.countUp(this.monthlyExpensesTarget, this.monthlyExpensesValue);
    }
    if (this.hasHistoryTarget) {
      this.historyTarget.textContent = 0;
      this.countUp(this.historyTarget, this.historyValue);
    }
    if (this.hasMonthlySubsTarget) {
      this.monthlySubsTarget.textContent = 0;
      this.countUp(this.monthlySubsTarget, this.monthlySubsValue);
    }
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
