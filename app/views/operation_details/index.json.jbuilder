# frozen_string_literal: true

json.array! @operation_details, partial: 'operation_details/operation_detail', as: :operation_detail
