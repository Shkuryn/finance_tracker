# frozen_string_literal: true

class CreateOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :operations, id: false do |t|
      t.string :comment
      t.boolean :marked
      t.datetime :date
      t.primary_key :id
      t.integer :user_id

      t.timestamps
    end
  end
end
