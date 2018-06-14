class AddRegestirationTokenToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :reg_token, :string
  end
end
