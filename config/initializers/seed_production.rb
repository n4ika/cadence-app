if Rails.env.production?
  Rails.application.config.after_initialize do
    User.connection.execute("SELECT 1") # Ensure DB connection
    if User.count == 0
      load(Rails.root.join("db", "seeds.rb"))
    end
  end
end