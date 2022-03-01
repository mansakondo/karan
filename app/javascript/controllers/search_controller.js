import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "form", "facets", "results", "pagination" ]

  connect() {
  }

  displayResults() {
    this.formTarget.requestSubmit()
  }

  updateFacets() {
    this.facetsTarget.src = this.resultsTarget.src
  }
}
