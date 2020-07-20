module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    #8.5 helperで説明されている。
  end
  
  def logged_in?
    !!current_user
  end
end
