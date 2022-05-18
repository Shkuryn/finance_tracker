# frozen_string_literal: true

class AddIdToIncome < ActiveRecord::Migration[6.1]
  def change
    add_column :incomes, :id, :primary_key
  end
end
