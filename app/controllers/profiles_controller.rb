class ProfilesController < ApplicationController
  skip_before_action :authorize_request, only: [:show], raise: false
  before_action :set_user_by_params

  def show
    render_profile false
  end

  def follow
    @current_user.follow @user

    render_profile @current_user.does_follow_another_user(@user)
  end

  def unfollow
    @current_user.unfollow @user

    render_profile @current_user.does_follow_another_user(@user)
  end

  private

  def set_user_by_params
    @user = User.find_by_username(params[:username])
  end

  def render_profile(does_user_follow_another_user)
    render json: {
      profile: {
        username: @user.username,
        bio: @user.bio,
        image: @user.image,
        following: does_user_follow_another_user
      }
    }
  end
end
