# frozen_string_literal: true

class OperationDetailsController < ApplicationController

  respond_to :html, :xml, :json
  before_action :set_operation_detail, only: %i[show edit update destroy]
  before_action :check_params, only: %i[create]
  # GET /operation_details or /operation_details.json
  def index
    @operation_details = OperationDetail.all
  end

  # GET /operation_details/1 or /operation_details/1.json
  def show
    @operation_detail = OperationDetail.new(operation_detail_params)
    @operation = Operation.find(OperationDetail.find(params[:id]).operation_id)
    redirect_to edit_operation_url(@operation)
  end


  # GET /operation_details/new
  def new
    @operation_detail = OperationDetail.new
  end

  # GET /operation_details/1/edit
  def edit
    @expences = Expence.all
    @expence = Expence.find(@operation_detail.expence_id)
  end

  # POST /operation_details or /operation_details.json
  def create
    @operation_detail = OperationDetail.new(operation_detail_params)
    @operation = Operation.find(@operation_detail.operation_id)
    respond_with @operation do |format|
      if @operation_detail.save
        format.html { redirect_to edit_operation_url(@operation), notice: 'Operation was successfully updated.' }
      end
    end
  end

  # PATCH/PUT /operation_details/1 or /operation_details/1.json
  def update
    @operation = Operation.find(@operation_detail.operation_id)
    respond_to do |format|
      if @operation_detail.update(operation_detail_params[:operation_detail])
        format.html { redirect_to edit_operation_url(@operation), notice: 'Operation detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation_details/1 or /operation_details/1.json
  def destroy
    @operation = Operation.find(@operation_detail.operation_id)
    @operation_detail.destroy
    respond_to do |format|
      format.html { redirect_to edit_operation_path(@operation), notice: 'Operation detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation_detail
    @operation_detail = OperationDetail.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def operation_detail_params
    params.permit(:comment, :amount, :operation_id, :id, :expence_id,
                  :_method, :authenticity_token, :commit,
                  operation_detail: %i[amount comment expence_id])
  end

  def check_params
    if @operation_detail.nil? && params[:amount].blank?
      redirect_to edit_operation_path(params[:operation_id]),
                  notice: 'Amount must be filled!'
    end
  end
end
