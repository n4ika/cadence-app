import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["content"]

  connect() {
    // Listen for Bootstrap dropdown show event
    this.element.addEventListener('show.bs.dropdown', () => {
      this.loadNotifications()
    })
  }

  loadNotifications() {
    fetch('/notifications/recent')
      .then(response => response.text())
      .then(html => {
        this.contentTarget.innerHTML = html
      })
  }
}


