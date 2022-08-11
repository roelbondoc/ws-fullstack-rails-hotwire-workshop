import { Controller } from "@hotwired/stimulus"
import _ from "lodash"

// Connects to data-controller="auto-submit"
export default class extends Controller {
  initialize() {
    this.submit = _.debounce(this.submit, 250).bind(this);
  }

  submit() {
    this.element.requestSubmit();
  }
}
