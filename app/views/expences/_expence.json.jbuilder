# frozen_string_literal: true

json.extract! expence, :id, :created_at, :updated_at
json.url expence_url(expence, format: :json)
