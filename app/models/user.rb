class User < ActiveRecord::Base
  include Commentable

  attr_reader :password
  after_initialize :ensure_session_token

  has_many :goals
  has_many :posted_comments, class_name: "Comment"

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user.try(:valid_password?, password) ? user : nil
  end

  def valid_password?(input)
    BCrypt::Password.new(password_digest).is_password?(input)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    save!
    self.session_token
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
