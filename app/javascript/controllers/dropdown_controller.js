import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["menu"];

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden");
  }

  connect() {
    // Close the dropdown when clicking outside of it
    document.addEventListener("click", this.close.bind(this));
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }

  disconnect() {
    document.removeEventListener("click", this.close.bind(this));
  }
}