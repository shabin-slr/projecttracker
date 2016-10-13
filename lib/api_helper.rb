##
# The ApiHelper module is the common place for writing all the common methods in api controller
module ApiHelper
  ##
  # Idetify the user from authetication token passed in Http header
  def authenticate_user_from_token!
    headers = request.headers
    email = headers["USER-EMAIL"].presence
    @user  = email && User.find_by_email(email)    
    if @user && Devise.secure_compare(@user.authentication_token, headers["AUTH-TOKEN"])
      sign_in @user, store: false
      @current_user = @user
    else
      @user = nil
    end
    render :status => 401, :json => {errors: ["Invalid Auth token"]} if @user.blank?
  end

  def read_fields_to_render
    @fields_to_render = []
    if(params[:fields] && params[:fields].length)
      params[:fields].map! do |str|
        str.to_sym
      end
      @fields_to_render = params[:fields]
    end
  end
  
end
