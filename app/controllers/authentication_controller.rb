class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, raise: false

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      expiration_time = (Time.now + 48.hours.to_i).strftime("%m-%d-%Y %H:%M")
      render json: { token: token, exp: expiration_time, username: @user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
