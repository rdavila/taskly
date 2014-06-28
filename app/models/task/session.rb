class Task::Session < ActiveRecord::Base
  belongs_to :task

  after_create :finish_other_running_sessions

  FINISHED_STATE = 'finished'

  include AASM

  aasm column: 'state' do
    state :running, initial: true
    state :finished

    event :finish do
      transitions from: :running, to: :finished
    end
  end

  private

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
