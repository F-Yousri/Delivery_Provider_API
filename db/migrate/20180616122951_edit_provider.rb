class EditProvider < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string
    rename_column :users, :password_digest, :secret_key
  end
end
