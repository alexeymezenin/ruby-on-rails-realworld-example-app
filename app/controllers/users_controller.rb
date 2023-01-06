class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create], raise: false

  def current
    render json: @current_user.as_json(root: true)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(root: true), status: :created, location: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def custom_update
    if @current_user.update(user_params)
      render json: @current_user.as_json(root: true)
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :image, :bio)
  end
end
