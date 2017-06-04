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
        output = {:message => "Not enough address data to determine congressional district"}
        #Use the State to determine District
        if (params[:state])
            if (params[:state].length == 2)
              state = Admins::State.where(abbreviation: params[:state]).first
            else
              state = Admins::State.where(name: params[:state]).first
            end
            districts = Admins::District.where(state_id: state.id)
            if (districts.length == 1)
                output = {:district => districts[0].name, :state => state.abbreviation}
                render json: output and return
            end
        end
    
        #Use the Zip to determine District
        if (params[:zip])
            zips = Admins::Zip.where(code: params[:zip])
            if (zips.empty?)
                url = 'https://congress.api.sunlightfoundation.com'
                conn = Faraday.new(:url => url) 
                response = conn.get '/districts/locate', { :apikey => '123', :zip => params[:zip] }
                repo_info = {:count => 0}
                if (response.success?) 
                  repo_info = JSON.parse(response.body)
                end
                if (repo_info["count"] > 0)
                    zip_record = Admins::Zip.new(code: params[:zip])
                    repo_info['results'].each do |item|
                        state_record = Admins::State.where(abbreviation: item['state']).first
                        district_record = Admins::District.where(number: item['district'], state_id: state_record.id).first
                        if (district_record)
                            zip_record.districts << district_record;
                        else
                            output = {:message => 'District not found in the database'}
                        end
                    end
                    zip_record.save
                    if (zip_record.districts.length > 1)
                        output = {:message => 'Zip code cannot be used to determine district because there are multiple districts for this zip code.'}
                    elsif (zip_record.districts.length == 1)
                        output = {:district => zip_record.districts[0].number, :state => zip_record.districts[0].state.abbreviation}
                        render json: output and return
                    else
                        output = {:message => 'Zip code may not be valid.  It was not found in the congressional database[1]'}
                    end
                else
                    output = {:message => 'Zip code may not be valid.  It was not found in the congressional database[2]'}
                end
            else
                if (zips[0].districts.length == 1)
                    output = {:district => zips[0].districts[0].number, :state => zips[0].districts[0].state.abbreviation}
                    render json: output and return
                else
                    output = {:message => "Zip code cannot be used to determine district because there are multiple districts for this code"}
                end  
            end
        end
    
        #User address,city,state to determine District
        if (params[:address] && params[:city] && params[:state])
            query = "#{params[:address]} #{params[:city]} #{params[:state]}"
            encoded_query = URI.encode(query)
            url = 'https://www.googleapis.com'
            conn = Faraday.new(:url => url) do |faraday|
                faraday.response :detailed_logger
                faraday.adapter Faraday.default_adapter
            end
            response = conn.get '/civicinfo/v2/representatives', { :key => 'AIzaSyCnf229S5uGfG2gRpnE6npbHXZZgOxOyNo', :address => query, :includeOffices => 'false', :roles => 'legislatorLowerBody' }
            Rails.logger.debug "NANCY: response.body: #{response.body}"
            repo_info = JSON.parse(response.body)
            if (repo_info['divisions'])
                if (repo_info['divisions'].keys.first)
                    Rails.logger.debug "NANCY: keys.first: #{repo_info['divisions'].keys.first}"
                    key = repo_info['divisions'].keys.first
                    splits =key.split(':')
                    Rails.logger.debug "NANCY: splits.length: #{splits.length}"
                    if (splits.length == 4)
                        state_record = Admins::State.where(abbreviation: params[:state]).first
                        district_record = Admins::District.where(number: splits[3], state_id: state_record.id).first
                        state = ""
                        if (district_record) 
                            state = district_record.state.abbreviation
                        end
                        render json: { :district => splits[3], :state => state} and return
                    else
                        render json: { :message => 'Could not find district for this address[1]'} and return
                    end
                else 
                    render json: { :message => 'Could not find district for this address[2]'} and return
                end
            else
                render json: { :message => 'Could not find district for this address[3]'} and return
            end 
            output = {:message => 'Cannot determine district with just state information as this state has multiple districts'}
            render json: output and return
        else
            render json: output and return
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
