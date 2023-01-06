require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "should get index" do
    get comments_url, as: :json
    assert_response :success
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post comments_url, params: { comment: { article_id: @comment.article_id, body: @comment.body, user_id: @comment.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show comment" do
    get comment_url(@comment), as: :json
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { article_id: @comment.article_id, body: @comment.body, user_id: @comment.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment), as: :json
    end

    assert_response :no_content
  end
end
