class Cheer < ActiveRecord::Base

  validates :user_id, uniqueness: { scope: :goal_id }
  validate :cant_exceed_max_cheers

  belongs_to :user
  belongs_to :goal

  private

  def cant_exceed_max_cheers
    if User.find(user_id).cheers.count > 10
      errors.add(:base, "Can't exceed max amount of cheers")
    end
  end

end
