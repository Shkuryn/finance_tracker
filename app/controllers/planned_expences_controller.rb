# frozen_string_literal: true

class PlannedExpencesController < ApplicationController
  helper PlannedExpencesHelper
  before_action :set_planned_expence, only: %i[show edit update destroy]
  before_action :set_expence, only: %i[index new edit show]
  before_action :check_user_owner, only: %i[show edit]
  before_action :check_user_signed, only: %i[show new edit update destroy index]

  def index
    @planned_expences = PlannedExpence.with_user(current_user.id) unless current_user.nil?
  end

  def new
    @planned_expence = PlannedExpence.new
  end

  def edit; end

  def show; end

  def create
    @planned_expence = PlannedExpence.new(planned_expence_params)
    @planned_expence.user_id = current_user.id
    @planned_expence.sent = false
    @user = current_user

    respond_to do |format|
      if @planned_expence.save
        PlannedExpenceMailer.delay(run_at: @planned_expence.date).notification_about_expence(@user, @planned_expence)
        format.html { redirect_to planned_expence_url(@planned_expence), notice: 'Planned Expence was successfully created.' }
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
        format.html { redirect_to planned_expence_url(@planned_expence), notice: 'Planned Expence was successfully updated.' }
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
      format.html { redirect_to planned_expences_url, notice: 'Planned Expence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def planned_expence_params
    params.require(:planned_expence).permit(:expence_id, :description, :date, :sent, :user_id, :amount, :id)
  end

  def set_planned_expence
    @planned_expence = PlannedExpence.find(params[:id])
  end

  def check_user_owner
    render template: 'welcome/index' if @planned_expence.user_id != current_user.id
  end

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  def set_expence
    @expence = Expence.where(predefined: true).or(Expence.with_user(current_user.id)) unless current_user.nil?
  end
end
