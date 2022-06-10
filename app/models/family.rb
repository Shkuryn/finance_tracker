# frozen_string_literal: true

class Family < ApplicationRecord
  has_many :users
  has_one :parent, class_name: "User", foreign_key: "parent_id"
end
