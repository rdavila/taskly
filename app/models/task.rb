class Task < ActiveRecord::Base
  attr_accessor :new_project_name

  validates :name, presence: true
  validates :project, presence: true, if: proc { |m| m.new_project_name.blank? }
  validates_associated :project

  belongs_to :project
  has_many   :sessions

  before_validation :create_project_if_required

  private

    def create_project_if_required
      if new_project_name.present?
        project = Project.create(name: new_project_name)
        self.project = project
      end
    end
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
