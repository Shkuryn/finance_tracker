# frozen_string_literal: true

class FamiliesController < ApplicationController
    def create
        @family = Family.new(family_params)
        @family.user_id = 
    end
end
