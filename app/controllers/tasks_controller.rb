class TasksController < ApplicationController

  include ApiHelper

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |controller| controller.request.format == 'application/json' }

  #POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id
    @task.save
    # @task = Task.new(task_params)
    render :status => :ok, :json => {:message => @task}
  end

  #tasks /tasks
  def index
    @tasks = Task.where("user_id = #{@current_user.id}")
    render :status => :ok, :json => {:tasks => @tasks}
  end


  private

  def task_params
    puts params.to_s
    params.required(:task).permit(:name,:description,:user_id)
  end
end
