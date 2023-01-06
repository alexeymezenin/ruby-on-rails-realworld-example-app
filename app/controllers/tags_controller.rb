class TagsController < ApplicationController
  skip_before_action :authorize_request, raise: false

  def index
    render json: { tags: Tag.pluck(:name) }
  end
end
