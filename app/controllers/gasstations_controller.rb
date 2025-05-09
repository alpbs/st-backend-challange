class GasstationsController < ApplicationController
  # GET /gasstations
  
  def index
    @gasstations = GasstationsServices::Index.new.perform

    render json: @gasstations
  end
end
