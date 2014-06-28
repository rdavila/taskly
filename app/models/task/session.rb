class Task::Session < ActiveRecord::Base
  belongs_to :task
end

# == Schema Information
#
# Table name: task_sessions
#
#  id          :integer          not null, primary key
#  task_id     :integer
#  finished_at :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_task_sessions_on_task_id  (task_id)
#
