require File.expand_path(File.dirname(__FILE__) + "/environment")
set :environment, :production
set :output, "#{Rails.root}/log/cron.log"
env :PATH, ENV['PATH']

every 25.minutes do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every 1.days, at: '11:00' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every 1.days, at: '13:00' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every 1.days, at: '15:00' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every 3.days, at: '14:20' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every 4.days, at: '17:20' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every :saturday, at: '11:30' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end

every :sunday, at: '12:30' do
  begin
    runner "Batch::LogCreate.log_create"
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end