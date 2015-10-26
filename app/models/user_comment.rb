class UserComment < ActiveRecord::Base

  validates :body, presence: true

  belongs_to :author, class_name: "User"
  belongs_to :user

end
