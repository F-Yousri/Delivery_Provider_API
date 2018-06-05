class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.float :x
      t.float :y
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
