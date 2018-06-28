class Api::V1::ContactsController < Api::V1::BaseController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :set_response_headers
  before_action :authenticate_user!
  def index
    contacts = paginate Users::Contact.all, per_page: 10

    render json: contacts, each_serializer: Api::V1::ContactSerializer
  end
  def new
    render json: {:user_id => current_user.id, :phone_id => params[:phone_id]} 
  end
  def details
    state = Admins::State.where(abbreviation: params[:state]).first
    if (state)
      politicians = Admins::Politician.where(state_id: state.id)
    end
    render json: politicians, each_serializer: Api::V1::PoliticianSerializer 
  end
  def test
    Rails.logger.debug "NANCY: params[phone_id]: #{params[:phone_id]}"
    render json: {status: "ok"}
  end
  def create
    contact_hash = {user_id: current_user.id, phone_id: params["phone_id"]}
    contact = Users::Contact.where({user_id: current_user.id, phone_id: params["phone_id"]})
    if (contact.empty?)
      @users_contact = Users::Contact.new(contact_hash)
      @users_contact.save
    end
  end
  def all
    if (params["ids"])
      len = params["ids"].length-1
      for i in 0..len
        contact_hash = {user_id: current_user.id, phone_id: params["ids"][i]}
        contact = Users::Contact.where(phone_id: params["ids"][i])
        if (contact.empty?)
          @users_contact = Users::Contact.new(contact_hash)
          @users_contact.save
        end
      end
    end
    
    render json: {:test => "ok"}
  end
  def check
    render json: {:status => "ok", :email => current_user.email} 
  end
  def set_response_headers
    if user_signed_in? and response.headers[DeviseTokenAuth.headers_names[:"access-token"]].nil?
      auth_header = {}
      auth_header[DeviseTokenAuth.headers_names[:"access-token"]] = ' '
      auth_header[DeviseTokenAuth.headers_names[:"expiry"]] = ' '
      response.headers.merge!(auth_header)
    end
  end
end
