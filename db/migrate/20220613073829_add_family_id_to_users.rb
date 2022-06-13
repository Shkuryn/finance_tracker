class AddFamilyIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :family_id, :integer
  end
end
