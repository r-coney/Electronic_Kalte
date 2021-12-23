class CreateKaltes < ActiveRecord::Migration[6.0]
  def change
    create_table :kaltes do |t|
      t.string :menu, null: false
      t.text :request
      t.text :menu_description, null: false
      t.text :note

      t.timestamps
    end
  end
end
