import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter-toggle"
export default class extends Controller {
  static targets = ["form"];

  toggle() {
    if (this.hasFormTarget) {
      this.formTarget.classList.toggle('is-hidden');
    }
  }
}
