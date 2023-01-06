class Comment < ApplicationRecord
  validates :body, presence: true, on: :create

  belongs_to :user
  belongs_to :article

  def as_json(options = {}, current_user = nil)
    super(options.merge(except: [:id, :user_id])).merge({
      author: user,
      following: (user.following.include? current_user)
    })
  end
end
