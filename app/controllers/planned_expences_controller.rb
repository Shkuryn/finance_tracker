class PlannedExpencesController < InheritedResources::Base

  private

    def planned_expence_params
      params.require(:planned_expence).permit(:expence_id, :description, :date, :sent, :user_id, :amount)
    end

end
