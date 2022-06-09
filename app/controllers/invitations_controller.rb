class InvitationsController < ApplicationController
    def create
        id1 = params[:ids][:id1]
        id2 = params[:ids][:id2]
        @invitation = Invitation.new(user_id: id1, member_id: id2)
        @invitation.save
        redirect_to current_user
    end

end
