# frozen_string_literal: true

class CreateOperationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :operation_details do |t|
      t.decimal :amount
      t.string :comment
      t.references :expences,  foreign_key: true
      t.references :operations, null: false, foreign_key: true

      t.timestamps
    end
  end
end
