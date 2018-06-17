class AddCityToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers ,:city ,:string
  end
end
