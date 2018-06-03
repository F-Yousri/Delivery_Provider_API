class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :title
      t.string :to
      t.string :from
      t.date :time
      t.string :images

      t.timestamps
    end
  end
end
