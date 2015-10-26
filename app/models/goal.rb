class Goal < ActiveRecord::Base
  include Commentable

  validates :description, presence: true

  belongs_to :user


end
