# frozen_string_literal: true

json.array! @planned_expences, partial: 'planned_expences/planned_expence', as: :planned_expence
