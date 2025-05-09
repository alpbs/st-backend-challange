class UsersController < ApplicationController
  # GET /users/:id
  before_action :set_user, only: [:show]
  
  def show
    @report = UsersServices::Report.new(@user).perform

    render json: @report
  end

  private

  def set_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end
end
