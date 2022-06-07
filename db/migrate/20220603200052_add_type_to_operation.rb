# frozen_string_literal: true

class AddTypeToOperation < ActiveRecord::Migration[6.1]
  def change
    add_column :operations, :type, :integer
  end
end
