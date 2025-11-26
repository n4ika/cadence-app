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
    console.log("updateBadge called with count:", count);
    console.log("this.element:", this.element);
    console.log("Searching for 'i' tag...");

    // Find the bell icon - use a more general selector
    const bellIcon = this.element.querySelector("i");
    console.log("Found icon:", bellIcon);

    if (!bellIcon) {
      console.error("Bell icon not found!");
      return;
    }

    if (count > 0) {
      // Show filled bell
      bellIcon.classList.remove("fa-regular");
      bellIcon.classList.add("fa-solid");
    } else {
      // Show outlined bell
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
