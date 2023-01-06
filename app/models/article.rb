class Article < ApplicationRecord
  before_save :generate_slug

  validates :title, :description, :body, presence: true
  validates :title, uniqueness: true, on: :create

  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users

  scope :fitler_by_tag, ->(name) { joins(:tags).where('tags.name = ?', name) }
  scope :filter_by_author, ->(username) { joins(:user).where('users.username = ?', username) }
  scope :filter_by_favorited, ->(username) { joins(:users).where('users.username = ?', username) }

  def sync_tags(tag_list)
    tag_list.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)

      tags << tag
    end
  end

  def favorite(user)
    users << user unless users.include? user
  end

  def unfavorite(user)
    users.delete user
  end

  def as_json(options = {}, current_user = nil)
    super(options.merge(except: [:id, :user_id])).merge({
      author: user,
      favorited: (users.include? current_user),
      favoritesCount: users.count,
      tagList: tags.pluck(:name)
    })
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
