class AddIndexMultiProfileUsername < ActiveRecord::Migration[5.2]
  def change
    add_index :multi_profiles, :username
    add_index :multi_profiles, :address_prefecture
  end
end
