import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "fieldset" ]

  connect() {
    console.log("Hello, Stimulus!", this.element);

    const checkboxTarget = this.element.querySelector("input[type=checkbox]")
    const fieldsetTarget = this.element.querySelector("fieldset[data-facet-component-target]")

    if (!checkboxTarget || !fieldsetTarget) return

    if (checkboxTarget.checked) {
      fieldsetTarget.disabled = false
      fieldsetTarget.classList.remove("hidden")
    }
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
