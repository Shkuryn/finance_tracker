class AddNameToPlannedExpences < ActiveRecord::Migration[6.1]
  def change
    add_column :planned_expences, :name, :string
  end
end
