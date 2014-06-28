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
      @tasks ||= Task.all
    end

    def save_task
      if @task.save
        redirect_to tasks_url
      end
    end

    def task_params
      task_params = params[:task]
      task_params ? task_params.permit(:name, :project_id, :new_project_name) : {}
    end
end
