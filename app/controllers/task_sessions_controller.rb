class TaskSessionsController < ApplicationController
  def start
    build_task_session
    save_task_session

    respond_to do |format|
      format.js do
        render :start, status: @task_session.persisted? ? 201 : 422
      end
    end
  end

  def stop
    load_task_session
    @task_session.finish

    respond_to do |format|
      format.js do
        render :stop, status: save_task_session ? 200 : 422
      end
    end
  end

  private
    def load_task_session
      @task_session ||= begin 
        load_task
        @task.sessions.find(params[:id])
      end
    end

    def build_task_session
      load_task
      @task_session ||= @task.sessions.build
    end

    def save_task_session
      @task_session.save
    end

    def load_task
      @task ||= Task.find(params[:task_id])
    end
end
