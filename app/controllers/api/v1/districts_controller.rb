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
    def show
      @district = Admins::District.find(params[:id])
      render json: @district, serializer: Api::V1::DistrictSerializer, include: ['politician']
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
                Rails.logger.debug "Got here"
                render json: districts[0], serializer: Api::V1::DistrictSerializer, include: ['politician'] and return
            end
        end
    
        #User address,city,state to determine District
        if (params[:faddress] || (params[:address] && params[:city] && params[:state]))
            if (params[:faddress])
              query = "#{params[:faddress]}"
            else
              query = "#{params[:address]} #{params[:city]} #{params[:state]}"
            end
          
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
                    key = repo_info['divisions'].keys.first
                    splits =key.split(':')
                    if (splits.length == 4)
                        state_record = Admins::State.where(abbreviation: repo_info['normalizedInput']['state']).first
                        district_record = Admins::District.where(number: splits[3], state_id: state_record.id).first
                        state = ""
                        if (district_record) 
                            state = district_record.state.abbreviation
                            state_id = district_record.state.id
                        end
                        render json: district_record, serializer: Api::V1::DistrictSerializer, include: ['politician'] and return
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
