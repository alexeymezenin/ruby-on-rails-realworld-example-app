class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, raise: false

  def login
    @user = User.find_by_email(params[:email])

    if @user&.authenticate(params[:password])
      @user_token = JsonWebToken.encode(user_id: @user.id)
      render json: @user.as_json.merge({ token: @user_token }), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
