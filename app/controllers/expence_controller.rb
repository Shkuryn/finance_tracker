class ExpenceController < ApplicationController
  def index
    @expences = Expence.all
  end
end
