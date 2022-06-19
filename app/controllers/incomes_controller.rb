# frozen_string_literal: true

class IncomesController < ApplicationController
  before_action :set_income, only: %i[show edit update destroy]
  before_action :check_user_signed, only: %i[show new edit update destroy]

  # GET /incomes
  def index
    @q = Income.where(predefined: true).or(Expence.with_user(current_user.id)).or(Income.with_family(current_user.family_id)).ransack(params[:q]) unless current_user.nil?
    @incomes = @q.result(distinct: true)
  end

  # GET /incomes/1
  def show; end

  # GET /incomes/new
  def new
    @income = Income.new
  end

  # GET /incomes/1/edit
  def edit
    @income = Income.find_by(id: params[:id])
  end

  # POST /incomes
  def create
    @income = Income.new(income_params)
    @income.user_id = current_user.id
    @income.predefined = false

    respond_to do |format|
      if @income.save
        format.html { redirect_to income_url(@income), notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to income_url(@income), notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  def destroy
    return if @income.predefined == true

    @income.destroy

    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_user_signed
    render template: 'welcome/index' unless user_signed_in?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_income
    @income = Income.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def income_params
    params.require(:income).permit(:name, :description, :id, :user_id)
  end
end
