class Task < ActiveRecord::Base
  attr_accessor :new_project_name

  validates :name, presence: true
  validates :project, presence: true, if: proc { |m| m.new_project_name.blank? }
  validates :new_project_name, presence: true, if: proc { |m| m.project_id.blank? }

  belongs_to :project
end

# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#
