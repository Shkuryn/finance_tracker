# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :member_id
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
