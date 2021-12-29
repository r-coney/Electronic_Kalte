class AddCustomerIdToKaltes < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM kaltes;'
    add_reference :kaltes, :customer, null: false, index: true
  end

  def down
    remove_reference :kaltes, :customer, index: true
  end
end
