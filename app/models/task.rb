class Task < ActiveRecord::Base
  attr_accessor :new_project_name

  validates :name, presence: true
  validates :project, presence: true, if: proc { |m| m.new_project_name.blank? }
  validates_associated :project

  belongs_to :project
  has_many   :sessions

  before_validation :create_project_if_required

  def has_a_running_session?
    running_session.present?
  end

  def running_session
    sessions.running.first
  end

  def duration(date = nil)
    if date
      query = "DATE(finished_at AT TIME ZONE 'UTC' AT TIME ZONE ?) = ?"
      sessions.finished.where(query, Time.zone.tzinfo.identifier, date).to_a.sum(&:duration)
    else
      sessions.finished.to_a.sum(&:duration)
    end
  end

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
