module ApplicationHelper
  require 'net/http'
  require 'net/https'
  require 'digest/md5'
  require 'json'

  CREDENTIALS_API_KEY    = "<your_api_key>"
  CREDENTIALS_API_SECRET = "<your_api_secret>"
  CREDENTIALS_COMPANY_ID = "<your_company_id>"

  URL_LOGIN               = "https://b4.autodesk.com/api/security/v1/login.json"
  URL_LOGOUT              = "https://b4.autodesk.com/api/security/v1/logout.json"
  URL_PROJECT_LIST        = "https://b4.autodesk.com/api/project/v1/list.json"
  URL_PROJECT_INFO        = "https://b4.autodesk.com/api/project/v1/info.json"
  URL_MODEL_LIST          = "https://b4.autodesk.com/api/model/v1/list.json"
  URL_MODEL_INFO          = "https://b4.autodesk.com/api/model/v1/info.json"
  URL_VIEWER              = "https://b2.autodesk.com"

  def glue_login(login_name, password)
    url = URL_LOGIN
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    form_data = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :api_secret   => CREDENTIALS_API_SECRET,
      :timestamp    => timestamp,
      :sig          => sig,
      :login_name   => login_name,
      :password     => password
    }
    puts password
    request.set_form_data(form_data)

    response = http.request(request)
    return response
  end

  def glue_logout(auth_token)
    url = URL_LOGOUT
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    form_data = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :api_secret   => CREDENTIALS_API_SECRET,
      :timestamp    => timestamp,
      :sig          => sig,
      :auth_token   => auth_token
    }
    request.set_form_data(form_data)

    response = http.request(request)
    return response
  end

  def glue_get_projects(auth_token)
    url = URL_PROJECT_LIST
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    params = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :timestamp    => timestamp,
      :sig          => sig,
      :auth_token   => auth_token
    }
    uri.query = URI.encode_www_form(params)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return response
  end

  def glue_get_project_by_id(auth_token, project_id)
    url = URL_PROJECT_INFO
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    params = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :timestamp    => timestamp,
      :sig          => sig,
      :auth_token   => auth_token,
      :project_id   => project_id
    }
    uri.query = URI.encode_www_form(params)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    puts response.body
    return response
  end

  def glue_get_models(auth_token, project_id)
    url = URL_MODEL_LIST
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    params = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :timestamp    => timestamp,
      :sig          => sig,
      :auth_token   => auth_token,
      :project_id   => project_id
    }
    uri.query = URI.encode_www_form(params)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    return response
  end

  def glue_get_model_by_id(auth_token, model_id)
    url = URL_MODEL_INFO
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    params = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :timestamp    => timestamp,
      :sig          => sig,
      :auth_token   => auth_token,
      :model_id     => model_id
    }
    uri.query = URI.encode_www_form(params)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    puts response.body
    return response
  end

  def glue_get_view_url_by_id(auth_token, action_id, name, model_id, model_name)
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)

    params = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :timestamp    => timestamp,
      :sig          => sig,
      :auth_token   => auth_token
    }
    url = URL_VIEWER
    url += "?"+URI.encode_www_form(params) + "&runner=embedded/#adn/action/" + action_id
    result = {"url" => url, "name" => name, "model_id" => model_id, "model_name" => model_name}
    puts result
    return result
  end
end
