class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authorize_request

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      render_unauthorized
    rescue JWT::DecodeError
      render_unauthorized
    end
  end

  def owner?(model)
    model.user_id == @current_user.id
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
