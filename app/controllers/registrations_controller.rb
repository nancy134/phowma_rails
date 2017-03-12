class RegistrationsController < Devise::RegistrationsController
  def new
    flash[:notice] = 'Registrations blocked for admin'
    redirect_to root_path
  end

  def create
    flash[:notice] = 'Registrations blocked for admin'
    redirect_to root_path
  end
  protected

end
