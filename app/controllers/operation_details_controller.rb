class OperationDetailsController < ApplicationController
  before_action :set_operation_detail, only: %i[ show edit update destroy ]

  # GET /operation_details or /operation_details.json
  def index
    @operation_details = OperationDetail.all
  end

  # GET /operation_details/1 or /operation_details/1.json
  def show
  end

  # GET /operation_details/new
  def new
    @operation_detail = OperationDetail.new
  end

  # GET /operation_details/1/edit
  def edit
  end

  # POST /operation_details or /operation_details.json
  def create
    @operation_detail = OperationDetail.new(operation_detail_params)

    respond_to do |format|
      if @operation_detail.save
        format.html { redirect_to operation_detail_url(@operation_detail), notice: "Operation detail was successfully created." }
        format.json { render :show, status: :created, location: @operation_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation_details/1 or /operation_details/1.json
  def update
    respond_to do |format|
      if @operation_detail.update(operation_detail_params)
        format.html { redirect_to operation_detail_url(@operation_detail), notice: "Operation detail was successfully updated." }
        format.json { render :show, status: :ok, location: @operation_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation_details/1 or /operation_details/1.json
  def destroy
    @operation_detail.destroy

    respond_to do |format|
      format.html { redirect_to operation_details_url, notice: "Operation detail was successfully destroyed." }
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
      params.fetch(:operation_detail, {})
    end
end
