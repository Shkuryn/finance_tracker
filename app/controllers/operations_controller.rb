# frozen_string_literal: true

class OperationsController < ApplicationController
  helper OperationsHelper
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :check_user_signed, only: %i[show new edit update destroy index]
  before_action :set_operation_details, only: %i[show edit]
  before_action :check_user_owner, only: %i[show edit]

  # GET /operations or /operations.json
  def index
    params[:q] ||= {}
    if params[:q][:date_lteq].present?
      params[:q][:date_lteq] = params[:q][:date_lteq].to_date.end_of_day
    end

    @q = if params[:q][:operation_details_amount].to_i.positive? && params[:compare].present?
           case params[:compare]
           when '>='
             Operation.with_family(current_user.family_id).or(Operation.with_user(current_user.id)).with_amount_gteq(params[:q][:operation_details_amount])
                      .ransack(params[:q])
           when '>'
             Operation.with_family(current_user.family_id).or(Operation.with_user(current_user.id)).with_amount_gt(params[:q][:operation_details_amount])
                      .ransack(params[:q])
           when '='
             Operation.with_family(current_user.family_id).or(Operation.with_user(current_user.id)).with_amount_eq(params[:q][:operation_details_amount])
                      .ransack(params[:q])
           when '<='
             Operation.with_family(current_user.family_id).or(Operation.with_user(current_user.id)).with_amount_lteq(params[:q][:operation_details_amount])
                      .ransack(params[:q])
           when '<'
             Operation.with_family(current_user.family_id).or(Operation.with_user(current_user.id)).with_amount_lt(params[:q][:operation_details_amount])
                      .ransack(params[:q])
           end
         else

           Operation.with_user(current_user.id).or(Operation.with_family(current_user.family_id)).ransack(params[:q])
         end
    @operations = @q.result(distinct: true)
  end

  # GET /operations/1 or /operations/1.json
  def show; end

  # GET /operations/new
  def new
    @safari = request.env['HTTP_USER_AGENT'].scan('Safari').present?
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id))
    @incomes = Income.where(predefined: true).or(Income.with_user(current_user.id))
    @operation = Operation.new
    @operation_type = params[:type] == 'income' ? 1 : 0
  end

  # GET /operations/1/edit
  def edit
    @expences = Expence.where(predefined: true).or(Expence.with_family(current_user.family_id))
    @incomes = Income.where(predefined: true).or(Income.with_family(current_user.family_id))
    @operation_type = @operation.operation_type
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)
    @expences = Expence.where(predefined: true).or(Expence.with_family(current_user.family_id))
    @incomes = Income.where(predefined: true).or(Income.with_family(current_user.family_id))

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

  def set_operation_details
    @operation_details = @operation.operation_details
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.require(:operation).permit(:comment, :cover_picture, :marked, :date, :id, :operation_type,
                                      :user_id, :compare, :image, :remove_attached_image)
  end

  def check_user_owner
    render template: 'welcome/index' if @operation.user_id != current_user.id &&
      User.with_family(current_user.family_id).pluck(:id).include?(@operation.user_id).blank?
  end
end
