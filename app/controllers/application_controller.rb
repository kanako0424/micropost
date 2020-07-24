class ApplicationController < ActionController::Base
  
  include SessionsHelper
  #controller からhelperのメソッドを使うことはデフォルトではできない。
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
    #unlessはfalseの時に実行する。
    #ApplicationControllerにメソッドを定義すると、全てのコントローラーに反映される。
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end 
end
