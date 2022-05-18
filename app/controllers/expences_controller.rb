# frozen_string_literal: true

class ExpencesController < ApplicationController
  before_action :set_expence, only: %i[show edit update destroy]
  before_action :check_user_signed, only: %i[show new edit update destroy]

  # GET /expences or /expences.json
  def index
    @expences = Expence.where(predefined: true).or(Expence.with_user(current_user.id)) unless current_user.nil?
  end

  # GET /expences/1 or /expences/1.json
  def show; end

  # GET /expences/new
  def new
    @expence = Expence.new
  end

  # GET /expences/1/edit
  def edit
    @expence = Expence.find_by(id: params[:id])
  end

  # POST /expences or /expences.json
  def create
    @expence = Expence.new(expence_params)
    @expence.user_id = current_user.id
    @expence.predefined = false

    respond_to do |format|
      if @expence.save
        format.html { redirect_to expence_url(@expence), notice: 'Expence was successfully created.' }
        format.json { render :show, status: :created, location: @expence }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expences/1 or /expences/1.json
  def update
    respond_to do |format|
      if @expence.update(expence_params)
        format.html { redirect_to expence_url(@expence), notice: 'Expence was successfully updated.' }
        format.json { render :show, status: :ok, location: @expence }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expences/1 or /expences/1.json
  def destroy
    return if @expence.predefined == true

    @expence.destroy

    respond_to do |format|
      format.html { redirect_to expences_url, notice: 'Expence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_expence
    @expence = Expence.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expence_params
    params.require(:expence).permit(:name, :description, :id, :user_id)
  end
end
