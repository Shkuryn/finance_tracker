# frozen_string_literal: true

json.extract! income, :id, :created_at, :updated_at
json.url income_url(income, format: :json)
