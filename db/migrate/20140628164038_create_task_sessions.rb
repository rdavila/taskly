class CreateTaskSessions < ActiveRecord::Migration
  def change
    create_table :task_sessions do |t|
      t.references :task, index: true
      t.datetime :finished_at

      t.timestamps
    end
  end
end
