# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :check_user_signed, only: %i[show new edit update destroy index]

  def index; end

  def show
    @planned_expences_current_month = planned_current_month
    @balance = balance
    @balance_percent = '25'
    @spent_current_month = spent_current_month
    @incomes_current_month = incomes_current_month
    @expences_chart_data = OperationDetail.joins('INNER JOIN expences on expences.id =operation_details.expence_id')
                                          .joins(:operation).where(operation: { user_id: current_user.id })
                                          .where('date BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month)
                                          .group(:name).sum(:amount)
                                          .sort_by { |_key, value| value }.reverse.to_h
    @incomes_chart_data = OperationDetail.joins('INNER JOIN incomes on incomes.id =operation_details.income_id')
                                         .joins(:operation).where(operation: { user_id: current_user.id })
                                         .where('date BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month)
                                         .group(:name).sum(:amount)
                                         .sort_by { |_key, value| value }.reverse.to_h
  end

  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  def spent_current_month
    OperationDetail.joins(:operation).where(operation: { user_id: current_user.id })
                   .where(operation: { operation_type: 0 })
                   .where('date BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month)
                   .sum(:amount)
  end

  def incomes_current_month
    OperationDetail.joins(:operation).where(operation: { user_id: current_user.id })
                   .where(operation: { operation_type: 1 })
                   .where('date BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month)
                   .sum(:amount)
  end

  def planned_current_month
    PlannedExpence.with_user(current_user.id)
                  .where('date BETWEEN ? AND ?', Date.current.beginning_of_month, Date.current.end_of_month).sum(:amount)
  end

  def balance
    OperationDetail.joins(:operation).where(operation: { user_id: current_user.id })
                   .where(operation: { operation_type: 1 })
                   .where('date  <= ?', Date.current.end_of_day)
                   .sum(:amount) -
      OperationDetail.joins(:operation).where(operation: { user_id: current_user.id })
                     .where(operation: { operation_type: 0 })
                     .where('date  <= ?', Date.current.end_of_day)
                     .sum(:amount)
  end
end
