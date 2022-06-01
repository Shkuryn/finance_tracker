class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :operation_details, :operations_id, :operation_id
    rename_column :operation_details, :expences_id, :expence_id
  end
end
