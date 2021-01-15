class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tourist, null: false, foreign_key: true
      t.string :lang, null: false
      t.text :post_review, null: false
      t.integer :rating, null: false
      t.timestamps
    end
  end
end
