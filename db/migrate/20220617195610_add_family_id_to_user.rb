# frozen_string_literal: true

class AddFamilyIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :family_id, :bigint
  end
end
