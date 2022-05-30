class PlannedExpencesController < ApplicationController
  before_action :set_expence, only: %i[show edit update destroy]
  before_action :check_user_owner, only: %i[show edit]

  def index
    @planned_expences = PlannedExpence.where(PlannedExpence.with_user(current_user.id))
  end

  def new
    @planned_expence = PlannedExpence.new
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
