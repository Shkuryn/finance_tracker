class RemoveUsersIdFromFamilies < ActiveRecord::Migration[6.1]
  def change
    remove_column :families, :users_id, :bigint
  end
end
