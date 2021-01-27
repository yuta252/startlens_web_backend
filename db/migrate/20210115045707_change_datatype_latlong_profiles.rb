class ChangeDatatypeLatlongProfiles < ActiveRecord::Migration[5.2]
  def change
    change_column :profiles, :latitude, :decimal, precision: 12, scale: 8
    change_column :profiles, :longitude, :decimal, precision: 12, scale: 8
  end
end
