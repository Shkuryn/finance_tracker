# frozen_string_literal: true

class ChartsController < ApplicationController
  def show
    @data = OperationDetail.joins('INNER JOIN expences on expences.id =operation_details.expence_id')
                           .group(:name).sum(:amount)
  end
<<<<<<< HEAD
=======

  def index; end
>>>>>>> rubocop autocorrected
end
