class RemoveNameFromPlannedExpence < ActiveRecord::Migration[6.1]
  def change
    remove_column :planned_expences, :name, :string
  end
end
