class ChangeLongitudeAndLatitudeForOrdersModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :from, :src_latitude 
    add_column :orders ,:src_longitude ,:float

    rename_column :orders, :to, :dest_latitude 
    add_column :orders ,:dest_longitude ,:float
    
  end
end
