class ChangeDriverLocations < ActiveRecord::Migration[5.2]
  def change
    rename_column :drivers, :x, :latitude
    rename_column :drivers, :y, :longitude
    
  end
end
