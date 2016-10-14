class ActivitiesController < ApplicationController
  
  include ApiHelper
  include TaskHelper
  include ActivityHelper

  before_filter :get_task, :only => [:create, :index, :destroy, :update]
  before_filter :get_activity, :except=>[:create]

  def create
    @activity = Activity.new(activity_params)
    @activity.task_id = @task.id
    @activity.save
    # @task = Task.new(task_params)
    render :status => :ok, :json => {:activity => @activity.as_json}
  end

  def update
    if @activity.update_attributes(activity_params)
      render :status => :ok, :json => {:activity=> @activity}
    else
      render :status => :bad_request, :json => {:message => @activity.errors}
    end
  end

  def index
    activities = Activity.where("task_id = #{@task.id}")
    render :status => :ok, :json => {:activities => activities.as_json}
  end

  def delete

  end

  private

  def activity_params
    puts params.to_s
    params.required(:activity).permit(:description, :date, :hours_spent)
  end
end
