class Operation < ApplicationRecord
  has_many :operation_details, dependent: :destroy
end
