class Batch::LogCreate
  def self.log_create
    user = UserStatistic.new(
      user_id: 1,
      tourist_id: rand(1..100).to_i
    )
    user.save(validate: false)
    p "create new log"
  endbundle
end