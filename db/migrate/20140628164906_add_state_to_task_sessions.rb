class AddStateToTaskSessions < ActiveRecord::Migration
  def change
    add_column :task_sessions, :state, :string
  end
end
