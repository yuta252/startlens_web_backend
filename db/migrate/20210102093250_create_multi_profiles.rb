class CreateMultiProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :multi_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :lang, null: false
      t.string :username, null: false
      t.text :self_intro, null: false
      t.string :address_prefecture
      t.string :address_city
      t.string :address_street
      t.string :entrance_fee
      t.string :business_hours
      t.string :holiday
      t.integer :translated
      t.timestamps
    end

    add_index :multi_profiles, [:user_id, :lang], unique: true
  end
end
