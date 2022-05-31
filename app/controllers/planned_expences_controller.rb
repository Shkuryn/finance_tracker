# frozen_string_literal: true

class PlannedExpencesController < ApplicationController
  def index; end

  def new
    @planned_expence = PlannedExpence.new
  end

  def edit
    @planned_expence = PlannedExpence.find_by(id: params[:id])
  end

  def create
    @planned_expence = PlannedExpence.new
    @planned_expence.user_id = current_user.id
    @planned_expence.sent = false
  end

  private

  def planned_expence_params
    params.require(:planned_expence).permit(:expence_id, :description, :date, :sent, :user_id, :amount)
  end
end
