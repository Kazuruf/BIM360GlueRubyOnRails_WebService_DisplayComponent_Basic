class ModelsController < ApplicationController
  def show
    auth_token = session[:auth_token]
    response = glue_get_model_by_id(auth_token, params[:id])
    if response.code == '200'
      result = JSON.parse(response.body)
      @model = result
    end
  end
end
