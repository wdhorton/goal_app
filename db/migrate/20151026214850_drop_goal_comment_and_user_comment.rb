class DropGoalCommentAndUserComment < ActiveRecord::Migration
  def change
    drop_table :goal_comments
    drop_table :user_comments
  end
end
