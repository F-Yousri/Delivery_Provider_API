class AddPasswordToDriversModel < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers ,:password_digest , :string
  end
end
