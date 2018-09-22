class Admins::PoliticiansController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_admins_politician, only: [:show, :edit, :update, :destroy]

  # GET /admins/politicians
  # GET /admins/politicians.json
  def index
    @search = Admins::Politician.ransack(params[:q])
    @admins_politicians = @search.result.includes(:office).paginate(page: params[:page], per_page: 10)
  end

  # GET /admins/politicians/1
  # GET /admins/politicians/1.json
  def show
  end

  # GET /admins/politicians/new
  def new
    @admins_politician = Admins::Politician.new
  end

  # GET /admins/politicians/1/edit
  def edit
  end

  # POST /admins/politicians
  # POST /admins/politicians.json
  def create
    @admins_politician = Admins::Politician.new(admins_politician_params)

    respond_to do |format|
      if @admins_politician.save
        format.html { redirect_to @admins_politician, notice: 'Politician was successfully created.' }
        format.json { render :show, status: :created, location: @admins_politician }
      else
        format.html { render :new }
        format.json { render json: @admins_politician.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/politicians/1
  # PATCH/PUT /admins/politicians/1.json
  def update
    respond_to do |format|
      if @admins_politician.update(admins_politician_params)
        format.html { redirect_to @admins_politician, notice: 'Politician was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_politician }
      else
        format.html { render :edit }
        format.json { render json: @admins_politician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/politicians/1
  # DELETE /admins/politicians/1.json
  def destroy
    @admins_politician.destroy
    respond_to do |format|
      format.html { redirect_to admins_politicians_url, notice: 'Politician was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Admins::Politician.import(params[:file])
    redirect_to action: "index"
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_admins_politician
      @admins_politician = Admins::Politician.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_politician_params
      params.require(:admins_politician).permit(
        :first_name,
        :last_name,
        :party,
        :avatar,
        :twitter,
        :twitter_bio,
        :twitter_image,
        :twitter_banner,
        :facebook)
    end
end
