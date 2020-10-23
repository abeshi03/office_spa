class RemoveUserIdFromReservations < ActiveRecord::Migration[6.0]
  def change
    remove_column :reservations, :user_id, :integer
  end
end
