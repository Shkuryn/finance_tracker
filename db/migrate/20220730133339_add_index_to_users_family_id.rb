class AddIndexToUsersFamilyId < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :family_id
  end
end
