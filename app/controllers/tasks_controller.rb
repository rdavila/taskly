class TasksController < ApplicationController
  def index
    load_tasks
  end

  def new
    build_task
  end

  def create
    build_task
    save_task || render(:new)
  end

  private

    def build_task
      @task ||= Task.new
      @task.attributes = task_params
    end

    def load_tasks
      @filtered_date       = params[:d].present? ? Date.parse(params[:d]) : Date.current
      time_zone_identifier = Time.zone.tzinfo.identifier

      if @filtered_date == Date.current
        query = "DATE(created_at AT TIME ZONE 'UTC' AT TIME ZONE ?) = ?"
        @tasks ||= task_scope.where(query, time_zone_identifier, @filtered_date)
      else
        query = <<-eos
          DATE(task_sessions.created_at AT TIME ZONE 'UTC' AT TIME ZONE ?) = ? 
          AND DATE(task_sessions.finished_at AT TIME ZONE 'UTC' AT TIME ZONE ?) = ?
        eos
        @tasks ||= task_scope.joins(:sessions)
                    .where(query, time_zone_identifier, @filtered_date, time_zone_identifier, @filtered_date)
      end
    rescue ArgumentError
      not_found
    end

    def save_task
      if @task.save
        redirect_to tasks_url
      end
    end

    def task_scope
      Task.includes(:sessions).all
    end

    def task_params
      task_params = params[:task]
      task_params ? task_params.permit(:name, :project_id, :new_project_name) : {}
    end
end
