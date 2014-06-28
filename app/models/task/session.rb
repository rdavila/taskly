class Task::Session < ActiveRecord::Base
  belongs_to :task

  include AASM

  aasm column: 'state' do
    state :running, initial: true
    state :finished

    event :finish do
      transitions from: :running, to: :finished
    end
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
