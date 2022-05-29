# frozen_string_literal: true

json.extract! planned_expence, :id, :created_at, :updated_at
json.url planned_expence_url(planned_expence, format: :json)
