class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  
  #skip_before_action :authenticate_user!, :only =>[:create]
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |controller| controller.request.format == 'application/json' }


  #POST users/sign_up
  def create
    build_resource(sign_up_params)
    if resource.save
      response_message resource
    else
      clean_up_passwords resource
      return render :status => :bad_request, :json => {:message => resource.errors.full_messages}
    end
  end

  private
  
  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation,:first_name,:last_name,:mobile_number)
  end

  def response_message resource
    if resource.active_for_authentication?
      return render :status => :ok, :json => {:message => "Account created successfully"}
    else
      expire_data_after_sign_in!
      return render :status => :ok, :json => {:message => "Please confirm your account"}
    end
  end

end
