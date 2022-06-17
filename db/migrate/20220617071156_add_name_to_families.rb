class AddNameToFamilies < ActiveRecord::Migration[6.1]
  def change
    add_column :families, :name, :string
  end
end
