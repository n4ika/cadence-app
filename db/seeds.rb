# Clear existing data
Notification.destroy_all
Task.destroy_all
Project.destroy_all
User.destroy_all

# Create test user with notification preferences enabled
test_user = User.create!(
  email: "test@testemail.com",
  password: "password123",
  first_name: "Test",
  last_name: "User",
  email_notifications_enabled: true,
  in_app_notifications_enabled: true
)

# Project 1: Design System Refresh
project1 = Project.create!(
  title: "Design System Refresh",
  client: "TechCorp Inc.",
  project_type: "Design",
  start_date: Date.today - 5.days,
  estimated_end_date: Date.today + 25.days,
  user: test_user
)

Task.create!(title: "Audit existing design components", description: "Document all current components and their usage across the product", due_date: Date.today + 5.days, status: "pending", project: project1)
Task.create!(title: "Create design token specifications", description: "Define color palettes, typography scales, and spacing systems", due_date: Date.today + 12.days, status: "pending", project: project1)
Task.create!(title: "Build Figma component library", description: "Implement all components in Figma with variants and documentation", due_date: Date.today + 21.days, status: "pending", project: project1)

# Project 2: E-commerce Platform Migration
project2 = Project.create!(
  title: "E-commerce Platform Migration",
  client: "RetailMax",
  project_type: "Web Development",
  start_date: Date.today,
  estimated_end_date: Date.today + 45.days,
  user: test_user
)

Task.create!(title: "Set up Shopify Plus environment", description: "Configure new Shopify Plus instance with custom apps", due_date: Date.today + 3.days, status: "in_progress", project: project2)
Task.create!(title: "Migrate product catalog", description: "Import 5000+ products with images and variants", due_date: Date.today + 10.days, status: "pending", project: project2)
Task.create!(title: "Set up payment gateway integration", description: "Configure Stripe, PayPal, and Apple Pay", due_date: Date.today + 8.days, status: "pending", project: project2)

# Project 3: Mobile App Development
project3 = Project.create!(
  title: "Fitness Tracking Mobile App",
  client: "FitFlow Startup",
  project_type: "Mobile Development",
  start_date: Date.today + 1.day,
  estimated_end_date: Date.today + 60.days,
  user: test_user
)

Task.create!(title: "Design wireframes and user flows", description: "Create wireframes for all app screens", due_date: Date.today + 7.days, status: "completed", project: project3)
Task.create!(title: "Set up Firebase backend", description: "Configure Firestore, Authentication, and Cloud Functions", due_date: Date.today + 2.days, status: "in_progress", project: project3)
Task.create!(title: "Build user authentication flow", description: "Implement email/password and social login", due_date: Date.today + 9.days, status: "pending", project: project3)

# Project 4: Website Redesign
project4 = Project.create!(
  title: "Company Website Redesign",
  client: "GlobeConnect Ltd.",
  project_type: "Web Design",
  start_date: Date.today - 3.days,
  estimated_end_date: Date.today + 22.days,
  user: test_user
)

Task.create!(title: "Brand strategy workshop", description: "Conduct stakeholder interviews and define positioning", due_date: Date.today - 2.days, status: "completed", project: project4)
Task.create!(title: "High-fidelity mockups", description: "Design homepage, about, services, and contact pages", due_date: Date.today + 4.days, status: "in_progress", project: project4)
Task.create!(title: "Frontend development", description: "Build responsive website using Next.js and Tailwind", due_date: Date.today + 12.days, status: "pending", project: project4)

# Project 5: Analytics Dashboard
project5 = Project.create!(
  title: "Real-time Analytics Dashboard",
  client: "DataViz Solutions",
  project_type: "Full Stack Development",
  start_date: Date.today + 2.days,
  estimated_end_date: Date.today + 50.days,
  user: test_user
)

Task.create!(title: "Define analytics metrics", description: "Work with team to identify key metrics to track", due_date: Date.today + 1.day, status: "completed", project: project5)
Task.create!(title: "Database schema design", description: "Design optimized schema for time-series data", due_date: Date.today + 6.days, status: "pending", project: project5)
Task.create!(title: "Build API endpoints", description: "Create REST endpoints for analytics data", due_date: Date.today + 13.days, status: "pending", project: project5)

puts "✅ Seed data created!"
puts "Test User: test@testemail.com / password123"
puts "Projects: #{Project.count} | Tasks: #{Task.count}"