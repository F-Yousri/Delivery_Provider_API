class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.float :min_weight
      t.float :max_weight
      t.string :vehicle_kind
      t.string :vehicle_number
      t.float :vehicle_cost_rate

      t.timestamps
    end
  end
end
