class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :major_category, default: 0
      t.decimal :latitude
      t.decimal :longitude
      t.string :telephone, default: ""
      t.text :company_site

      t.timestamps
    end
  end
end
