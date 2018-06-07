class AddCostToOrdersModel < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cost, :float ,default: 0
  end
end
