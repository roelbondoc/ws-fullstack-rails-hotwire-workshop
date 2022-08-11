import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-toggle"
export default class extends Controller {
  static targets = ["modal"];

  show() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add('is-active');
    }
  }

  hide() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove('is-active');
    }
  }
}
