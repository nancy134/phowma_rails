class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
end
