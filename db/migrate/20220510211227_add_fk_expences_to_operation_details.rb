class AddFkExpencesToOperationDetails < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key "operation_details", "expences"
  end
end
