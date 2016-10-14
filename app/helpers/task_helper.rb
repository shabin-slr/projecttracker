module TaskHelper
  def get_task
    @task = Task.find_by_id(params[:id])
    if @task == nil
      render :status => :not_found, :json => {:message => "Task Not Found"}
    end
  end 
end
