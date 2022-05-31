# frozen_string_literal: true

class CreateIncomes < ActiveRecord::Migration[6.1]
  def change
    create_table :incomes do |t|
      t.string :name
      t.string :description
      t.boolean :predefined
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
