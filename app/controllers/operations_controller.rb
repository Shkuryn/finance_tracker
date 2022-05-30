# frozen_string_literal: true

class OperationsController < ApplicationController
  helper OperationsHelper
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :check_user_signed, only: %i[show new edit update destroy index]
  before_action :check_user_owner, only: %i[show edit]

  # GET /operations or /operations.json
  def index
    params[:q] ||= {}
    if params[:q][:date_lteq].present?
      params[:q][:date_lteq] = params[:q][:date_lteq].to_date.end_of_day
    end

    unless current_user.nil?
      @q = Operation.with_user(current_user.id).with_amount_gteq(params[:q][:operation_details_amount])
                    .ransack(params[:q])
    end

    @operations = @q.result(distinct: true)
  end

  # GET /operations/1 or /operations/1.json
  def show
    @operation_details = @operation.operation_details
  end

  # GET /operations/new
  def new
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id))
    @operation = Operation.new
    @operation_details = @operation.operation_details
  end

  # GET /operations/1/edit
  def edit
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id))
    @operation_details = @operation.operation_details
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)
    respond_to do |format|
      if @operation.save
        format.html { redirect_to edit_operation_url(@operation), notice: 'Operation was successfully created.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to edit_operation_url(@operation), notice: 'Operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.require(:operation).permit(:comment, :marked, :date, :id, :user_id, :compare)
  end

  def check_user_owner
    render template: 'welcome/index' if @operation.user_id != current_user.id
  end
end
