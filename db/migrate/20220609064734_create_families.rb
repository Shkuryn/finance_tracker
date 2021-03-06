# frozen_string_literal: true

class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.references :user, null: true, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
  end
end
