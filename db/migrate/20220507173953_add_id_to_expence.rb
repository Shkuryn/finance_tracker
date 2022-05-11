# frozen_string_literal: true

class AddIdToExpence < ActiveRecord::Migration[6.1]
  def change
    add_column :expences, :id, :primary_key
  end
end
