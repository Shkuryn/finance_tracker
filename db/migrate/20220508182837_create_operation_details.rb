class CreateOperationDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :operation_details, id: false do |t|
      t.decimal :amount
      t.primary_key :id
      t.integer :operation_id
      t.integer :expence_id
      t.string :comment
      t.timestamps
    end
  end
end
