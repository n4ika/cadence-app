# Cadence - Task Management & Deadline Tracking

> **Status:** Work in Progress / Proof of Concept
>
> A Ruby on Rails task management application for freelancers to organize projects, track deadlines, and receive intelligent notifications. Built as a portfolio project to demonstrate full-stack Rails development, background job processing, and real-time web features.

## Current Features

- **User Authentication** - Secure sign up and login via Devise
- **Project Management** - Create, read, and update projects with client information and timeline tracking
- **Task Management** - Full CRUD operations for tasks with due dates, descriptions, and status tracking (pending, in_progress, completed)
- **Dashboard** - Centralized view of all projects and tasks at a glance
- **Authorization** - Role-based access control ensuring users only see/modify their own projects and tasks
- **Notification Preferences** - Users can customize notification settings (email alerts, in-app alerts, priority filtering)

## Technical Architecture

### Why These Technologies?

**Sidekiq for Background Jobs**
Freelancers juggle multiple clients and deadlines. Rather than making users wait for notification checks during every request, Sidekiq processes deadline checks asynchronously in the background. This keeps the dashboard responsive while ensuring deadline notifications are sent reliably, even during traffic spikes.

**ActionCable for Real-Time Updates**
When a task status changes or a new task is added, the dashboard updates instantly without requiring a page refresh. ActionCable enables WebSocket connections that push changes to all connected clients in real-time.

**PostgreSQL**
Relational data (users → projects → tasks → notifications) naturally fits a SQL database. PostgreSQL's robustness and JSON support provide flexibility for future feature expansion.

**Bootstrap for Styling**
Quick, consistent UI for the POC. Focus is on functionality and architecture, not design polish.

## Current Stack

- **Backend:** Ruby on Rails 8.1
- **Database:** PostgreSQL
- **Authentication:** Devise
- **Background Jobs:** Sidekiq (Redis)
- **Real-Time:** ActionCable (WebSockets)
- **Frontend:** HTML/ERB, Vanilla JavaScript, Bootstrap
- **Testing:** RSpec (planned)

## Planned Features

- [ ] **Real-Time Dashboard Updates** - WebSocket integration to push task/project changes to all connected users instantly
- [ ] **Intelligent Deadline Notifications** - Background job that checks task deadlines and sends email + in-app notifications based on priority and user preferences
- [ ] **Task Archiving** - Soft delete for completed/abandoned tasks with reasoning (completed, deprioritized, abandoned)
- [ ] **Recurring Tasks** - Support for repeating tasks with customizable intervals
- [ ] **Analytics Dashboard** - Visualize project timelines, task completion rates, and deadline patterns
- [ ] **Email Notifications** - Transactional emails for deadline alerts and task assignments
- [ ] **Mobile Responsiveness** - Optimize UI for mobile and tablet devices
- [ ] **Test Suite** - Comprehensive RSpec tests for models, controllers, and background jobs
- [ ] **Modal Forms** - Refactor inline forms into polished modal dialogs with smooth transitions
- [ ] **API Endpoints** - RESTful API for programmatic access

## Screenshots

Screenshots coming soon

## How to Run Locally

### Prerequisites

- Ruby 3.x
- Rails 8.1
- PostgreSQL
- Redis (for Sidekiq)

### Setup

```bash
# Clone the repo
git clone <repo-url>
cd cadence-app

# Install dependencies
bundle install

# Setup database
rails db:create db:migrate db:seed

# Install JavaScript dependencies
yarn install

# Start Redis (in a separate terminal)
redis-server

# Start Sidekiq (in a separate terminal)
bundle exec sidekiq

# Start Rails server
rails server
```

Visit `http://localhost:3000` and create an account or use seeded test data.

## Technical Highlights

This project demonstrates:

- Full-stack Rails application architecture
- Background job processing and asynchronous operations
- Real-time web features with WebSockets
- Authentication and authorization patterns
- RESTful API design
- Database modeling for relational data
- Database schema design and migrations
- Testing practices (planned)

## Next Steps

1. Implement Sidekiq background job for deadline notifications
2. Integrate ActionCable for real-time dashboard updates
3. Build comprehensive test suite with RSpec
4. Refactor UI with modal forms and improved styling
5. Deploy to production environment

---

**Built by Naïka** | [GitHub](https://github.com/n4ika) | [Email](naika.c.estriplet@gmail.com)
