class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    # def helloWorld
    #     a = {}
    #     a[:b] = [1,2,3]
    #     a[:c] = 20
    #     #render :nothing => true
    #     #respond_to :json 
    #     #puts "route received /home568469634265444444444444444444444444465452344564345665256234546234546234546234546234546234546234546234"
    #     render xml: a
    # end
end
