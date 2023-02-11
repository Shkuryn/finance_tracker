# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :check_user_signed, only: %i[show new edit update destroy index]

  def index
    @members = User.with_family(current_user.family_id).pluck(:name)
    @family = User.with_family(current_user.family_id)
  end

  def create
    params_hash = params.to_unsafe_h
    dates_and_params(params_hash)
    set_members
    set_chart_data
    render 'charts/index'
  end

  private

  def dates_and_params(params_hash)
    @start_date1 = params_hash['/charts?method=post'].fetch('start_date(1i)')
    @start_date2 = params_hash['/charts?method=post'].fetch('start_date(2i)')
    @start_date3 = params_hash['/charts?method=post'].fetch('start_date(3i)')
    @end_date1 = params_hash['/charts?method=post'].fetch('end_date(1i)')
    @end_date2 = params_hash['/charts?method=post'].fetch('end_date(2i)')
    @end_date3 = params_hash['/charts?method=post'].fetch('end_date(3i)')
    @object_for_analyze = params_hash['/charts?method=post'].fetch('object_for_analyze')
    @type_of_chart = params_hash['/charts?method=post'].fetch('type_of_chart')
    @start_date = Date.civil(@start_date1.to_i, @start_date2.to_i, @start_date3.to_i)
    @end_date = Date.civil(@end_date1.to_i, @end_date2.to_i, @end_date3.to_i)
    @by_members = params_hash['/charts?method=post'].fetch('by_members')
  end

  def set_members
    @members = User.with_family(current_user.family_id).pluck(:name)
  end

  def set_chart_data
    @chart_data = if @object_for_analyze == 'Expences'
                    OperationDetail.joins('INNER JOIN expences on expences.id =operation_details.expence_id')
                                   .joins(:operation)
                                   .where(operation: { user_id: members_id })
                                   .where('date BETWEEN ? AND ?',
                                          @start_date.present? ? @start_date : DateTime.new(2022, 1, 1, 0, 0, 0), @end_date.present? ? @end_date : DateTime.new(2100, 1, 1, 0, 0, 0))
                                   .group(:name).sum(:amount)
                                   .sort_by { |_key, value| value }.reverse.to_h
                  else
                    OperationDetail.joins('INNER JOIN incomes on incomes.id =operation_details.expence_id')
                                   .joins(:operation)
                                   .where(operation: { user_id: members_id })
                                   .where('date BETWEEN ? AND ?',
                                          @start_date.present? ? @start_date : DateTime.new(2022, 1, 1, 0, 0, 0), @end_date.present? ? @end_date : DateTime.new(2100, 1, 1, 0, 0, 0))
                                   .group(:name).sum(:amount)
                                   .sort_by { |_key, value| value }.reverse.to_h
                  end
  end

  def check_user_signed
    render 'welcome/index' unless user_signed_in?
  end

  def members_id
    if @by_members.count > 1
      User.with_family(current_user.family_id).where('name IN (?)', @by_members)
    else
      User.where('id = ?', current_user.id)
    end
  end
end
