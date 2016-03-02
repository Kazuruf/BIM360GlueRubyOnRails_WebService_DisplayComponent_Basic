class SessionsController < ApplicationController
  def new
  end

  def create
    login_name = params[:session][:login_name]
    password = params[:session][:password].to_s
    response = glue_login login_name, password

    puts "[Login Response] [#{response.code}] #{response.message}: #{response.body}"

    if response.code == '200'
      result = JSON.parse(response.body)
      save_session login_name, result["auth_token"]
      redirect_to root_path
    else
      flash.now[:danger] = "[#{response.code}] #{response.message}: #{response.body}"
      render 'new'
    end
  end

  def destroy
    auth_token = session[:auth_token]
    delete_session
    response = glue_logout auth_token
    puts "[Logout Response] [#{response.code}] #{response.message}: #{response.body}"
    redirect_to root_path
  end
end
