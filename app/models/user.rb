# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  def as_json(options={})
    super(root: 'user', only: [:email, :username, :bio, :image])
  end
end
