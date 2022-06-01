# frozen_string_literal: true

json.extract! planned_expence, :id, :expence_id, :description, :date, :sent, :user_id, :amount, :created_at, :updated_at
json.url planned_expence_url(planned_expence, format: :json)
