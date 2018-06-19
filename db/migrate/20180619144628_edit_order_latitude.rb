class EditOrderLatitude < ActiveRecord::Migration[5.2]
  def change
  remove_column :orders, :src_latitude , :string
  remove_column :orders, :dest_latitude , :string
  add_column :orders ,:src_latitude ,:float
  add_column :orders ,:dest_latitude ,:float
  end
end
