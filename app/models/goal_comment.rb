class GoalComment < ActiveRecord::Base

  validates :body, presence: true

  belongs_to :goal
  belongs_to :author, class_name: "User"

end
