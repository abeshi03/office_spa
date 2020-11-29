class AddMenuIdToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :menu_id, :integer, null: false
  end
end
