require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference("User.count") do
      post '/api/users', params: { user: { bio: @user.bio, email: 'different@email.com', image: @user.image, password: 'secret', username: 'Different username' } }, as: :json
    end

    assert_response :created
  end
end
