class GlueViewsController < ApplicationController
  def show
    auth_token = session[:auth_token]
    response = glue_get_view_url_by_id(auth_token, params[:id], params[:name], params[:model_id], params[:model_name])
    puts response
    @glue_view = response
  end
end
