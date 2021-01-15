class CreateTourists < ActiveRecord::Migration[5.2]
  def change
    create_table :tourists do |t|
      t.string :email, null: false
      t.index :email, unique: true
      t.string :password_digest, null: false
      t.string :username, null: false
      t.string :thumbnail
      t.integer :sex, default: 0, null: false
      t.integer :birth, default: 0, null: false
      t.string :country, default: "na", null: false
      t.string :lang, deafult: "na", null: false
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
