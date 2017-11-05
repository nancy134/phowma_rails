class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User
  has_many :contacts, class_name: 'Users::Contact'
  # This is needed because devise_auth_token sets this to null in
  # DeviseTokenAuth::Concerns::User
  def send_confirmation_notification?
    return self.web
  end

end
