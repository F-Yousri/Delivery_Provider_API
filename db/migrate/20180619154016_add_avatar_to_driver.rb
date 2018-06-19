class AddAvatarToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers ,:avatar ,:string
  end
end
