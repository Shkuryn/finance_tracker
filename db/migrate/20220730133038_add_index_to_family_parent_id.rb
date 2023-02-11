class AddIndexToFamilyParentId < ActiveRecord::Migration[6.1]
  def change
    add_index :families, :parent_id
  end
end
