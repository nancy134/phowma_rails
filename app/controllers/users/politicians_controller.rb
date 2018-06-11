class Users::PoliticiansController < ApplicationController

  #before_action :authenticate_user!
  before_action :set_users_politician, only: [:show, :edit, :update, :destroy]

  # GET /users/politicians
  # GET /users/politicians.json
  def index
    @search = Admins::Politician.ransack(params[:q])
    @users_politicians = @search.result.includes(:office).paginate(page: params[:page], per_page: 10)
  end

  # GET /users/politicians/1
  # GET /users/politicians/1.json
  def show
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_users_politician
      @users_politician = Admins::Politician.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_politician_params
      params.require(:admins_politician).permit(
        :first_name,
        :last_name,
        :party,
        :avatar,
        :twitter,
        :facebook)
    end
end
