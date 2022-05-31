# frozen_string_literal: true

class PlannedExpencesController < ApplicationController
  def index
    @planned_expences = PlannedExpence.where(Expence.with_user(current_user.id))
  end

  def new
    @planned_expence = PlannedExpence.new
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id))
  end

  def edit
    @planned_expence = PlannedExpence.find_by(id: params[:id])
  end

  def show
    @planned_expence = PlannedExpence.find(params[:id])
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id))
  end

  def create
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id))
    @planned_expence = PlannedExpence.new(planned_expence_params)
    @planned_expence.user_id = current_user.id
    @planned_expence.sent = false

    respond_to do |format|
      if @planned_expence.save
        format.html { redirect_to planned_expence_url(@planned_expence), notice: "Planned Expence was successfully created." }
        format.json { render :show, status: :created, location: @planned_expence }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @planned_expence.errors, status: :unprocessable_entity }
      end
    end
  end

  

  private

  def planned_expence_params
    params.require(:planned_expence).permit(:expence_id, :description, :date, :sent, :user_id, :amount, :name)
  end
end
