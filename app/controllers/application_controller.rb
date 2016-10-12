class ApplicationController < ActionController::Base
    
  #include ApiHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :authenticate_user!

  
  before_filter :authenticate_user_from_token!

end
