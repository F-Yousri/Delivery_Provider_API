class AddVehicleNameToVehicles < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles ,:vehicle_kind ,:string
    add_column :vehicles, :name, :string

  end
end
