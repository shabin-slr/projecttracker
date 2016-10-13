class UsersController < ApplicationController

  include ApiHelper

  def show
    puts "params[:id] : " + params[:id]
    puts "current_user[:id] : " + @current_user.id.to_s
    puts @current_user.tasks.length.to_s
    if (@current_user && @current_user.id == params[:id].to_i)
      render :status => :ok, :json => {
        :user => @current_user.as_json(
          :methods => User::METHODS_RENDERED,
          :only => User::FIELDS_RENDERED,
          include: {
            :tasks => {
              :methods => Task::METHODS_RENDERED,
              :only => Task::FIELDS_RENDERED
            }
          }
        )
      }
    else
      render :status => :unauthorized, :json => {:message => "Not Authorized"}
    end
  end


  private

  def get_user
    
  end    

end
