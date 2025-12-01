import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["content"];
  static values = {
    pollInterval: { type: Number, default: 30000 }, // 30 seconds
  };

  connect() {
    console.log("Notifications controller connected!");

    // Listen for Bootstrap dropdown show event
    this.element.addEventListener("show.bs.dropdown", () => {
      console.log("Dropdown opened!");
      this.loadNotifications();
    });

    // Start polling for unread count
    console.log("Starting polling...");
    this.startPolling();
  }

  disconnect() {
    // Stop polling when element is removed
    this.stopPolling();
  }

  startPolling() {
    // Update count immediately
    this.updateUnreadCount();

    // Then poll at interval
    this.pollTimer = setInterval(() => {
      this.updateUnreadCount();
    }, this.pollIntervalValue);
  }

  stopPolling() {
    if (this.pollTimer) {
      clearInterval(this.pollTimer);
    }
  }

  updateUnreadCount() {
    fetch("/notifications/unread_count")
      .then((response) => response.json())
      .then((data) => {
        this.updateBadge(data.count);
      });
  }

  updateBadge(count) {
    // Find the bell - works for both <i> and <svg> after FA transformation
    const bellIcon = this.element.querySelector(".fa-bell");

    if (!bellIcon) {
      console.error("Bell icon not found!");
      return;
    }

    if (count > 0) {
      bellIcon.classList.remove("fa-regular");
      bellIcon.classList.add("fa-solid");
    } else {
      bellIcon.classList.remove("fa-solid");
      bellIcon.classList.add("fa-regular");
    }
  }

  loadNotifications() {
    fetch("/notifications/recent")
      .then((response) => response.text())
      .then((html) => {
        this.contentTarget.innerHTML = html;
        // After loading, update count (some notifications were just marked read)
        this.updateUnreadCount();
      });
  }
}
