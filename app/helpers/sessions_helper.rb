module SessionsHelper
  def save_session(login_name, auth_token)
    session[:login_name] = login_name
    session[:auth_token] = auth_token
  end
  def delete_session()
    session.delete(:login_name)
    session.delete(:auth_token)
  end
end
