class Task::Session < ActiveRecord::Base
  include Task::SessionStates

  belongs_to :task

  before_create :flag_as_running
  after_create  :finish_other_running_sessions
  before_save   :set_finished_at

  private
    def set_finished_at
      if state_changed? && state == FINISHED_STATE
        self.finished_at = Time.now
      end
    end

    def flag_as_running
      self.state = RUNNING_STATE
    end

    def finish_other_running_sessions
      task.sessions.running.where.not(id: id).update_all(state: FINISHED_STATE)
    end
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
#  state       :string(255)
#
# Indexes
#
#  index_task_sessions_on_task_id  (task_id)
#
