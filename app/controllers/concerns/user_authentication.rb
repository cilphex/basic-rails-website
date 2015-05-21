module UserAuthentication

  def self.included(base)
    base.helper_method :signed_in?
    base.helper_method :signed_out?
    base.helper_method :signed_in_as_admin?
    base.helper_method :signed_in_as?
    base.helper_method :current_user
  end

  def redirect_if_signed_in
    if signed_in?
      redirect_to home_index_path
    end
  end

  def authenticate_user
    if current_user.present?
      if current_user.active?
        true
      else
        permission_denied root_path, "Please confirm your email address before signing in."
        false
      end
    else
      permission_denied signin_path, "Please sign in first to perform this action."
      false
    end
  end

  def authenticate_admin
    return if !authenticate_user
    if current_user.admin?
      true
    else
      # Figure out how to render a 404 instead, maybe?
      permission_denied root_path, "That page does not exist."
    end
  end

  def signed_in?
    current_user.present?
  end

  def signed_out?
    !signed_in?
  end

  def signed_in_as_admin?
    signed_in? && current_user.admin?
  end

  def signed_in_as?(user)
    current_user == user
  end

  def current_user
    return @current_user if @current_user.present?
    if session[:session_token]
      @current_session = UserSession.load(session[:session_token])
      if @current_session.present?
        @current_user = @current_session.user
      else
        session[:session_token] = nil
      end
    end
    @current_user
  end

  def permission_denied(url, message)
    respond_to do |format|
      format.html do
        cookies[:return_to] = {value: request.fullpath, expires: 10.minutes.from_now } if request.get? && !request.xhr?
        redirect_to url, alert: message
      end
      format.js do
        # not implemented yet
      end
      format.json do
        render json: {errors: [message]}
      end
    end
  end

end