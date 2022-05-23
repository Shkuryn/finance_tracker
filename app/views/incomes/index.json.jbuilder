# frozen_string_literal: true

json.array! @incomes, partial: 'incomes/income', as: :income
