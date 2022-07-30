class AddIndexToOperationDetailsIncomeId < ActiveRecord::Migration[6.1]
  def change
    add_index :operation_details, :income_id
  end
end
