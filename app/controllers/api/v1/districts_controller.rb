class Api::V1::DistrictsController < Api::V1::BaseController
  require 'uri'
  require 'faraday'
  require 'faraday/detailed_logger'
  def index
    if (!params[:state_id])
      districts = Admins::District.all
    else
      districts = Admins::District.where(state_id: params[:state_id])
    end
    render json: districts, each_serializer: Api::V1::DistrictSerializer
  end
  def find
    if (params[:state])
      state = Admins::State.where(abbreviation: params[:state]).first
      districts = Admins::District.where(state_id: state.id)
      if (districts.length == 1)
        output = {:district => districts[0].name, :state => state.abbreviation}
        render json: output and return
      end
    end
    if (!params[:zip])
      if (params[:address] && params[:city] && params[:state])
        query = "#{params[:address]} #{params[:city]} #{params[:state]}"
        encoded_query = URI.encode(query)
        url = 'https://www.googleapis.com'
        conn = Faraday.new(:url => url) do |faraday|
          faraday.response :detailed_logger
          faraday.adapter Faraday.default_adapter
        end
        response = conn.get '/civicinfo/v2/representatives', { :key => 'AIzaSyCnf229S5uGfG2gRpnE6npbHXZZgOxOyNo', :address => query, :includeOffices => 'false', :roles => 'legislatorLowerBody' }
        repo_info = JSON.parse(response.body)
        if (repo_info['divisions'])
          if (repo_info['divisions'].keys.first)
            splits = repo_info['divisions'].keys.first.split(':')
            if (splits.length == 4)
              render json: { :district => splits[3]} and return
            else
              render json: { :message => 'Could not find district for this address'} and return
            end
          else 
            render json: { :message => 'Could not find district for this address'} and return
          end
        else
          render json: { :message => 'Could not find district for this address'} and return
        end 
      end
      output = {:message => 'Cannot determine district with just state information as this state has multiple districts'}
      render json: output and return
    else
      zips = Admins::Zip.where(code: params[:zip])
      if (zips.empty?)
        url = 'https://congress.api.sunlightfoundation.com'
        conn = Faraday.new(:url => url) 
        response = conn.get '/districts/locate', { :apikey => '123', :zip => params[:zip] }
        if (response.success?)
          repo_info = JSON.parse(response.body)
          zip_record = Admins::Zip.new(code: params[:zip])
          repo_info['results'].each do |item|
            state_record = Admins::State.where(abbreviation: item['state']).first
            district_record = Admins::District.where(number: item['district'], state_id: state_record.id).first
            if (district_record)
              zip_record.districts << district_record;
            else
              Rails.logger.debug "NANCY: district not found in db"
            end
          end
          zip_record.save
          if (zip_record.districts.length > 1)
            output = {:message => 'Zip code cannot be used to determine district because there are multiple districts for this zip code.'}
            render json: output and return
          else
            output = {:district => zip_record.districts[0].number}
          end
        end
      else
        if (zips[0].districts.length == 1)
          output = {:district => zips[0].districts[0].number}
        else
          output = {:message => "Zip code cannot be used to determine district because there are multiple districts for this code"}
        end  
        render json: output and return
      end
    end
    if response
      render json: response.body
    else
      render json:  "{}" 
    end
  end

  def test
    zip_record = Admins::Zip.new(code: params[:zip])
    state_record = Admins::State.where(abbreviation: params[:state]).first
    district_record = Admins::District.where(number: params[:district], state_id: state_record.id).first
    if (district_record)
      zip_record.districts << district_record;
    end
    zip_record.save
    render json:  "{}"
  end
end
