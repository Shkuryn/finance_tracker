# frozen_string_literal: true

class Operation < ApplicationRecord
  validates :date,
            inclusion: { in: 5.years.ago..5.years.from_now }
  has_many :operation_details, dependent: :destroy
  belongs_to :user
  has_one_attached :cover_picture
  validate :acceptable_image
  scope :with_user, ->(user_id) { where('user_id = ?', user_id) }
  scope :with_amount_gteq, lambda { |sum|
                             joins('left join operation_details on operations.id = operation_details.operation_id')
                               .group('id')
                               .having('sum(operation_details.amount) >= ?', sum)
                           }
  scope :with_amount_gt, lambda { |sum|
    joins('left join operation_details on operations.id = operation_details.operation_id')
      .group('id')
      .having('sum(operation_details.amount) > ?', sum)
  }
  scope :with_amount_eq, lambda { |sum|
    joins('left join operation_details on operations.id = operation_details.operation_id')
      .group('id')
      .having('sum(operation_details.amount) = ?', sum)
  }
  scope :with_amount_lteq, lambda { |sum|
    joins('left join operation_details on operations.id = operation_details.operation_id')
      .group('id')
      .having('sum(operation_details.amount) <= ?', sum)
  }
  scope :with_amount_lt, lambda { |sum|
    joins('left join operation_details on operations.id = operation_details.operation_id')
      .group('id')
      .having('sum(operation_details.amount) < ?', sum)
  }
  def acceptable_image
    return unless cover_picture.attached?

    if cover_picture.byte_size > 1.megabyte
      image_size = (cover_picture.byte_size / 1_000_000.0).round(2)
      errors.add(:cover_picture, "size #{image_size} MB exceeds 1 MB limit")
    end

    acceptable_types = ['image/jpeg', 'image/jpg', 'image/png']
    errors.add(:cover_picture, 'must be a JPEG or PNG') unless acceptable_types.include?(cover_picture.content_type)
  end
end
