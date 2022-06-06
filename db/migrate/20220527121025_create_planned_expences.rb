# frozen_string_literal: true

class CreatePlannedExpences < ActiveRecord::Migration[6.1]
  def change
    create_table :planned_expences do |t|
      t.references :expences, null: false, foreign_key: true
      t.string :description
      t.datetime :date
      t.boolean :sent
      t.references :user, null: false, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
