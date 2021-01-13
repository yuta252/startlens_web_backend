class CreateExhibitFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibit_favorites do |t|
      t.references :exhibit, null: false, foreign_key: true
      t.references :tourist, null: false, foreign_key: true
      t.timestamps
    end
  end
end
