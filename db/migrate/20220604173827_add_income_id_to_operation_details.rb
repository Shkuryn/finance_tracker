# frozen_string_literal: true

class AddIncomeIdToOperationDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :operation_details, :income_id, :integer
  end
end
