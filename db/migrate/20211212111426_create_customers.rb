class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.integer :gender, null: false
      t.date :birthday, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
