class Api::V1::StoresController < Api::V1::BaseController
  require 'uri'
  require 'faraday'
  def index
    page = 1
    @array = [] 
    Rails.logger.debug "NANCY: Authorization: #{request.headers['Authorization']}"
    Rails.logger.debug "NANCY: x-device-token: #{request.headers['X-Device-Token']}"
    Rails.logger.debug "NANCY: x-access-token: #{request.headers['X-Access-Token']}"
    #render json: {status: "ok", authorization: request.headers['Authorization'],devicetoken: request.headers['X-Device-Token'] }
    #return;

    begin
      url = 'http://ve-api-staging.herokuapp.com'
      conn = Faraday.new(:url => url)
      response = conn.get '/api/stores', {:page => page}, {'Authorization' => request.headers['Authorization'], 'X-Device-Token' => request.headers['X-Device-Token'], 'X-Access-Token' => request.headers['X-Access-Token']}

      preorder_subtree(response.body)
      repo_info = JSON.parse(response.body)
      total_pages = repo_info['pages']
      page += 1
    end while page < total_pages
    #render json: {status: "ok"}
    render json: @array.to_json
  end
  def preorder_subtree(body)
    repo_info = JSON.parse(body)
    if (repo_info['pages'] == 0)
      return;
    end
    repo_info['stores'].each do |item|
      name = item['name']
      name_array1 = name.split('<br>')
      if (name_array1.length > 0)
        name = name_array1[0]
        name_array2 = name_array1[0].split('**')
        if (name_array2.length > 2)
          name = name_array2[2] 
        end
      end
      if (!item['logo'].include? "medium.png") 
        @array << {:name => ActionController::Base.helpers.strip_tags(name), :id => item['id'], :display => name}
      end
      if (item['stores_count'])
        page = 1
        begin
          url = 'http://ve-api-staging.herokuapp.com'
          conn = Faraday.new(:url => url)
          id = item['id']
          path = "/api/stores/#{id}/stores"
          response = conn.get path, {:page => page}, {'Authorization' => 'Token token=RgDWBnKI9heQgp3Mdtq0ig', 'X-Device-Token' => '1003'}
          preorder_subtree(response.body)
          total_pages = repo_info['pages']
          page += 1
        end while page < total_pages
      end
    end
  end
end
