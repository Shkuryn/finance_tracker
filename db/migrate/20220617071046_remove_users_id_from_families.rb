# frozen_string_literal: true

class RemoveUsersIdFromFamilies < ActiveRecord::Migration[6.1]
  def change
    remove_column :families, :user_id, :bigint
  end
end
