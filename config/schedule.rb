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
# every :day, at: '10:00am' do
#   runner "Partner.attach_transaction_daily"
# end


# every 1.month, at: 'start of the month at 10am' do
#   runner "Partner.attach_transaction_monthly"
# end

# every 10.minutes do
#   runner "Payer.partner_balance_check"
#   rake 'transaction:notify_stuck'
# end

# every 2.hours do
#   runner "Transaction.monitoring_confirm_trx"
# end

# every 15.minutes do
#   runner "PartnerBalance.update_danamon_balance"
# end

every 5.minutes do
  rake 'transaction:stuck_transactions_alert'
end

# every 1.day, at: '10:00pm' do
#   runner "Balance.where.not(partner_id: nil).each{|x| x.update_balance_from_ledger(true)}"
# end

every 5.minutes do
  runner "PartnerBalance.update_danamon_balance"
  rake 'transaction:partners_balance_alert'
end

every 5.minutes do
  rake 'transaction:delayed_job_alert'
end
