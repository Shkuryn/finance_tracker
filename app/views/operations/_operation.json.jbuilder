# frozen_string_literal: true

json.extract! operation, :id, :comment, :marked, :date, :datetime, :id, :user_id, :created_at, :updated_at
json.url operation_url(operation, format: :json)
