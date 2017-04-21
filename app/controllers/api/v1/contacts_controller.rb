class Api::V1::ContactsController < Api::V1::BaseController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  def index
    contacts = Users::Contact.all
    render json: contacts, each_serializer: Api::V1::ContactSerializer
  end
end
