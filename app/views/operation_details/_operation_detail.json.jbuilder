# frozen_string_literal: true

json.extract! operation_detail, :id, :created_at, :updated_at
json.url operation_detail_url(operation_detail, format: :json)
