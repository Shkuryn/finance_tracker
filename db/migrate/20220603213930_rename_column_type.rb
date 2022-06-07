# frozen_string_literal: true

class RenameColumnType < ActiveRecord::Migration[6.1]
  def change
    rename_column :operations, :type, :operation_type
  end
end
