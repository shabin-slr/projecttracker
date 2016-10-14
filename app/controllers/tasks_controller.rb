class TasksController < ApplicationController

  include ApiHelper
  include TaskHelper

  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |controller| controller.request.format == 'application/json' }
  before_filter :get_task, :only => [:update, :delete, :destroy, :show]
  before_filter :validate_task_belongs_to_current_user, :only => [:update, :delete, :show, :destroy]

  #POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id
    @task.save
    # @task = Task.new(task_params)
    render :status => :ok, :json => {:task => @task.as_json(1,2,3)}
  end

  #GET /tasks
  # def index
  #   @tasks = Task.where("user_id = #{@current_user.id}")
  #   render :status => :ok, :json => {
  #     :tasks => @tasks.map do |task|
  #       {"name"=>task.name, "id"=>task.id}
  #     end,
  #     :user => @current_user.as_json(except: [:email] )
  #   }
  # end

  def index
    #puts params[:fields]
    fields_to_render = Task::FIELDS_RENDERED
    methods_to_render = Task::METHODS_RENDERED

    if(@fields_to_render.length > 0)
      fields_to_render = @fields_to_render&Task::FIELDS_RENDERED
      methods_to_render = @fields_to_render&Task::METHODS_RENDERED  
    end

    @tasks = Task.where("user_id = #{@current_user.id}")
    render :status => :ok, :json => {
      :tasks => @tasks.map do |task|
        task.as_json(
          :methods => methods_to_render,
          :only => fields_to_render,
          # include: {
          #   :user => {
          #     :methods => User::METHODS_RENDERED,
          #     :only => User::FIELDS_RENDERED,
          #   }
          # }
        )
      end,
      :user => @current_user
    }
  end

  #PUT /task/:id
  def update
    #if @task.save
    #@task.update_attributes(task_params)
    #@task.name = params[:task][:name]
    #@task.description = params[:task][:description]
    if @task.update_attributes(task_params)
      render :status => :ok, :json => {:task=> @task}
    else
      render :status => :bad_request, :json => {:message => @task.errors}
    end
  end

  def show
    render :status => :ok, :json => {:task=> @task.as_json(
      :methods => Task::METHODS_RENDERED,
      :only => Task::FIELDS_RENDERED,
      include: 
        {
          :user => {
            :methods => User::METHODS_RENDERED,
            :only => User::FIELDS_RENDERED
          }
        }
      )
    }
  end

  def destroy
    @task.destroy
    render :status => :ok, :json => {:task=> @task.as_json(only:[:name,:description,:id] )}
  end

  private

  def task_params
    puts params.to_s
    params.required(:task).permit(:name,:description,:user_id)
  end

  def validate_task_belongs_to_current_user
    #puts "inside validate_task_belongs_to_current_user"
    if  @task.user_id == @current_user.id
      return true
    else
      render :status => :unauthorized, :json => {:message => "Not Authorized"}
    end
  end
end
