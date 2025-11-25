every 15.minutes do
  runner "CheckDeadlinesJob.perform_now"
end