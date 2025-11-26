# Future schedule for production with priority levels
# Cost: ~$28/month on Render Cron Jobs
# every 15.minutes do
#   runner "CheckDeadlinesJob.perform_now"
# end

# POC schedule (set in Render dashboard): every hour at minute 12
# Cron syntax: 12 * * * *
# Cost: ~$7/month on Render Cron Jobs