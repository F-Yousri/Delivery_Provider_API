class ChangeDeviceTokenName < ActiveRecord::Migration[5.2]
  def change
    rename_column :drivers, :reg_token, :device_token
  end
end
