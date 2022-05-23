# frozen_string_literal: true

class ChartsController < ApplicationController
  before_action :check_user_signed, only: %i[show new edit update destroy index]
  def show
    @data = OperationDetail.joins('INNER JOIN expences on expences.id =operation_details.expence_id')
                           .group(:name).sum(:amount).sort_by { |_key, value| value }.reverse.to_h
  end

  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end
<<<<<<< HEAD
=======

  def index; end
>>>>>>> rubocop autocorrected
end
