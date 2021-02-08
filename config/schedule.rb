require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

if rails_env.to_sym != :development
  every 25.minutes do
    begin
      runner "Batch::LogCreate.log_create"
    rescue => e
      Rails.logger.error("aborted rails runner")
      raise e
    end
  end

  every 34.minutes do
    begin
      runner "Batch::LogCreate.log_create"
    rescue => e
      Rails.logger.error("aborted rails runner")
      raise e
    end
  end

  every 1.days, at: '13:00 am' do
    begin
      runner "Batch::LogCreate.log_create"
    rescue => e
      Rails.logger.error("aborted rails runner")
      raise e
    end
  end

  every 3.days do
    begin
      runner "Batch::LogCreate.log_create"
    rescue => e
      Rails.logger.error("aborted rails runner")
      raise e
    end
  end
end