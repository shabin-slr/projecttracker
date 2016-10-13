class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  
  #skip_before_filter :verify_authenticity_token#, :if => Proc.new { |controller| controller.request.format == 'application/json' }
  skip_before_filter :authenticate_user_from_token!, :only =>[:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = get_resource
    return failure if resource.blank? || !resource.confirmed?
    if resource.valid_password?(@user_password)
      resource.reset_authentication_token
      sign_in(:user, resource)
      resource.current_user = resource
      render :status => :ok, :json => {:user => resource }
      return
    end
    failure
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private
  
  def get_resource
    user_param = params[:user]
    user_email = user_param[:email]
    @user_password = user_param[:password]
    resource = User.find_for_database_authentication(:email => user_email )
    return resource
  end
  ##
  # Method will return error mesage when request is un authorized request
  def failure
    return render json: {:message => "Login Failed" }, :status => :bad_request
  end

end
