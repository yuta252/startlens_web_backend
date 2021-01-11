class AddIndexProfileMajorCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :profiles, :major_category
  end
end
