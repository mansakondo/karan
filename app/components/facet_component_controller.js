import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "fieldset" ]

  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  toggleChildren() {
    this.toggle(this.fieldsetTarget)
  }

  toggle(target) {
    target.toggleAttribute("disabled")
    target.classList.toggle("hidden")
  }

  reset() {
    const fieldsetTargets = document.querySelectorAll("fieldset[data-facet-component-target]")
    fieldsetTargets.forEach((target) => {
      target.disabled = true

      if (target.classList.contains("hidden")) return

      target.classList.add("hidden")
    })
  }
}
