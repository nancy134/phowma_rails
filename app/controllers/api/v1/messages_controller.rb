class Api::V1::MessagesController < Api::V1::BaseController

  def create
    message_hash = {name: params["name"], email: params["email"], message: params["message"]}
    message = Admins::Message.new(message_hash)
    message.save  
    render json: {id: message.id, name: message.name, email: message.email, message: message.message}
  end
end
