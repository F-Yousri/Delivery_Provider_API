class AddPickupAndDropoffLocationsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders ,:pickup_location ,:string
    add_column :orders ,:dropoff_location ,:string
  end
end
