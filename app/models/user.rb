# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password
  validates :username, :email, :password, presence: true
  validates :email, :username, uniqueness: true, on: :create

  has_and_belongs_to_many :following,
    class_name: 'User',
    join_table: 'followers',
    foreign_key: 'follower_id',
    association_foreign_key: 'following_id'

  has_and_belongs_to_many :followers,
    class_name: 'User',
    join_table: 'followers',
    foreign_key: 'following_id',
    association_foreign_key: 'follower_id'

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  def does_follow_another_user(user)
    following.include?(user)
  end

  def follow(user)
    following << user unless following.include? user
  end

  def unfollow(user)
    following.delete(user)
  end

  def as_json(options = {})
    super(options.merge(only: [:email, :username, :bio, :image]))
  end
end
