module ActivityHelper
  def get_activity
    @activity = Activity.find_by_id(params[:activity_id])
    if @activity == nil
      render :status => :not_found, :json => {:message => "Activity Not Found"}
    elsif @activity.task_id != @task.id
      render :status => :not_found, :json => {:message => "Activity not Found under current task"}
    else
      return true
    end
  end
end
