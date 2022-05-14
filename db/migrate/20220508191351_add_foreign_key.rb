# frozen_string_literal: true

class AddForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key 'operation_details', 'operations'
  end
end
