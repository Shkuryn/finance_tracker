# frozen_string_literal: true

module OperationsHelper
  def operation_sum(id)
    OperationDetail.where(operation_id: id).sum(:amount)
  end

  def author(user_id)
    user = User.find(user_id)
    "#{user.name} #{user.surname}"
  end
end
