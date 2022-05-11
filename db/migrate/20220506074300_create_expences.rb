# frozen_string_literal: true

class CreateExpences < ActiveRecord::Migration[6.1]
  def change
    create_table :operation, id: false do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.boolean :predefined
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
