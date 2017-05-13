class Api::V1::ContactsController < Api::V1::BaseController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  def index
    contacts = Users::Contact.all
    render json: contacts, each_serializer: Api::V1::ContactSerializer
  end
  def new
    render json: {:user_id => current_user.id, :phone_id => params[:phone_id]} 
  end
  def all
    if (params[:body])
      a = JSON.parse(params[:body])
      Rails.logger.debug "NANCY user_id: #{current_user.id}"
      len = a["ids"].length-1
      Rails.logger.debug "NANCY len: #{len}"
      for i in 0..len
        Rails.logger.debug "NANCY: phone_id #{a["ids"][i]}"
        contact_hash = {user_id: current_user.id, phone_id: a["ids"][i]}
        Rails.logger.debug "NANCY: contact_hash: #{contact_hash.to_json}"
        contact = Users::Contact.where(phone_id: a["ids"][i])
        if (contact.empty?)
          @users_contact = Users::Contact.new(contact_hash)
          @users_contact.save
        end
      end
    end
    
    render json: {:test => "ok"}
  end
  def check
    render json: {:status => "ok"} 
  end
end
