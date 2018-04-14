# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']

set :output, '/home/ba/Desktop/RoR/cron1.log'

every 1.day, :at => '02:47 pm' do
  runner "Copartjob.d_csv"
end

every 1.day, :at => '12:04 pm' do
  runner "Copartjob.run_filter"
end


every '@reboot' do
  command 'cd /home/ba/Desktop/RoR/skyscraper/ && RAILS_ENV=production rails s'
end
