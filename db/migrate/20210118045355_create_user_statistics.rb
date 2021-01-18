class CreateUserStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :user_statistics do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tourist, null: false, foreign_key: true
      t.timestamps
    end
  end
end
