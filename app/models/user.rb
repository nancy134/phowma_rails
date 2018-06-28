class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :contacts, class_name: 'Users::Contact'
  # This is needed because devise_auth_token sets this to null in
  # DeviseTokenAuth::Concerns::User
  def send_confirmation_notification?
    return self.web
  end


  def self.from_omniauth(auth)
    user = User.find_by('email = ?', auth['info']['email'])
    if user.blank?
      user = User.new(
      {
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0,20]
      }
      )
      user.save!
    end
    user
  end
end
