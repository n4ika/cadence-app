user = User.create(
  first_name: "Test",
  last_name: "User",
  email: "test@testemail.com",
  password: "password123",
  password_confirmation: "password123",
  email_notifications_enabled: false,
  in_app_notifications_enabled: true,
  high_priority_notifications_only: false
)

project1 = user.projects.create(
  title: "Website Migration",
  client: "Test Co"
)

task1 = project1.tasks.create(
  title: "Research Platforms",
  due_date: "2026-01-01"
)

task2 = project1.tasks.create(
  title: "Write project brief",
  description: "create docuement for client with prices and timelines",
  due_date: "2025-11-30"
)

project2 = user.projects.create(
  title: "New Website Build",
  client: "Ant Company"
)

task3 = project2.tasks.create(
  title: "Write project scope",
  due_date: "2025-11-26",
  status: "in_progress"
)

task4 = project2.tasks.create(
  title: "create brand guidelines",
  due_date: "2025-11-30"
)

task5 = project2.tasks.create(
  title: "source images and content",
  due_date: "2025-11-30"
)

