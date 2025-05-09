class RefuelingsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_gasstation, only: [:create]

  # POST /refuelings
  
  def create
    @refueling = RefuelingsServices::Create.new(user: @user, gasstation: @gasstation, quantity: refueling_params[:quantity]).perform

    if @refueling.errors.any?
      render json: { errors: @refueling.errors }, status: :unprocessable_entity
      return
    end

    render json: @refueling, status: :created
  end

  private

  def refueling_params
    params.require(:refueling).permit(
      :user_id,
      :gasstation_id,
      :quantity
    )
  end

  def set_user
    @user = User.find(refueling_params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :bad_request
  end
  
  def set_gasstation
    @gasstation = Gasstation.find(refueling_params[:gasstation_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Gas station not found" }, status: :bad_request
  end
end
