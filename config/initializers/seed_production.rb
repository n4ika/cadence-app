if Rails.env.production? && User.count == 0
  load(Rails.root.join("db", "seeds.rb"))
end