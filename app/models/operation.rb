# frozen_string_literal: true

class Operation < ApplicationRecord
  validates :date,
            inclusion: { in: 5.years.ago..5.years.from_now }
  has_many :operation_details, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  validate :acceptable_image
  # add ability to delete attached images
  attr_accessor :remove_attached_image

  after_save :purge_attached_image, if: :remove_attached_image?
  scope :with_family, lambda { |family_id|
    where('user_id IN (?)', User.with_family(family_id).pluck(:id))
  }
  # define the acceptable_image validation
  def acceptable_image
    return unless image.attached?

    if image.byte_size > 1.megabyte
      image_size = (image.byte_size / 1_000_000.0).round(2)
      errors.add(:image, "size #{image_size} MB exceeds 1 MB limit")
    end

    acceptable_types = %w[image/jpeg image/jpg image/png]
    errors.add(:image, 'must be a JPEG or PNG') unless acceptable_types.include?(image.content_type)
  end

  # define the after_save action to remove an image
  def remove_attached_image?
    remove_attached_image == '1'
  end

  def purge_attached_image
    image.purge_later
  end

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
end
