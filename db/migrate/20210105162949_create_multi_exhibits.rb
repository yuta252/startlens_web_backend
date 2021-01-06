class CreateMultiExhibits < ActiveRecord::Migration[5.2]
  def change
    create_table :multi_exhibits do |t|
      t.references :exhibit, null: false, foreign_key: true
      t.string :lang, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
