# frozen_string_literal: true

module OperationsHelper
  def operation_sum(id)
    OperationDetail.where(operation_id: id).sum(:amount)
  end

  def author(user_id)
    user = User.find(user_id)
    "#{user.name} #{user.surname}"
  end

  def income_name operation_detail
    Income.find(operation_detail.income_id).name
  end

  def expence_name operation_detail
    Expence.find(operation_detail.expence_id).name
  end
end
