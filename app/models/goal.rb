class Goal < ActiveRecord::Base

  validates :description, presence: true

  belongs_to :user
  has_many :comments, class_name: "GoalComment"

end
