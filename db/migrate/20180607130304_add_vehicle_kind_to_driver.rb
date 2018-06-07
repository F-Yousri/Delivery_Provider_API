class AddVehicleKindToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :vehicle_kind, :string
  end
end
