class AddVehicleIdToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :vehicle_id, :integer
  end
end
