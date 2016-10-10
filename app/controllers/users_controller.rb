class UsersController < ApplicationController
  protect_from_forgery
  def create
    user = User.new
    user.name = "Shabin"
    user.email = "shabinmohd@gmail.com"
    user.save

    render json:user
  end

end
