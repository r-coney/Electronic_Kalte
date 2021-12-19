class AddAddressToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :address, :string, null: false
  end
end
