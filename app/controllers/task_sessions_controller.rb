class TaskSessionsController < ApplicationController
  def index
    load_task_sessions
  end

  def update
    load_task_session
    @task_session.created_at = parse_datetime_params(task_session_params, 'created_at')
    @task_session.finished_at = parse_datetime_params(task_session_params, 'finished_at')

    respond_to do |format|
      format.js do
        render nothing: true, status: save_task_session ? 200 : 422
      end
    end
  end

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
    @task_session.mark_as_finished

    respond_to do |format|
      format.js do
        render :stop, status: save_task_session ? 200 : 422
      end
    end
  end

  private
    def load_task_sessions
      @task_sessions = Task::Session.finished
    end

    def load_task_session
      @task_session ||= if params[:task_id]
                          load_task
                          @task.sessions.find(params[:id])
                        else
                          Task::Session.find(params[:id])
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

    def task_session_params
      params[:task_session]
    end
    
end
