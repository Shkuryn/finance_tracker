# frozen_string_literal: true

class PlannedExpencesController < ApplicationController
  before_action :set_planned_expence, only: %i[show edit update destroy]

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

  def update
    respond_to do |format|
      if @planned_expence.update(planned_expence_params)
        format.html { redirect_to planned_expence_url(@planned_expence), notice: "Planned Expence was successfully updated." }
        format.json { render :show, status: :ok, location: @planned_expence }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @eplanned_xpence.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @planned_expence.destroy

    respond_to do |format|
      format.html { redirect_to planned_expences_url, notice: "Planned Expence was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def planned_expence_params
    params.require(:planned_expence).permit(:expence_id, :description, :date, :sent, :user_id, :amount, :name)
  end

  def set_planned_expence
    @planned_expence = PlannedExpence.find(params[:id])
  end
end
