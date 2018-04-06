class Admins::ElectionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_election, only: [:show, :edit, :update, :destroy]

  # GET /admins/elections
  # GET /admins/elections.json
  def index
    @search = Admins::Election.ransack(params[:q])
    @admins_elections = @search.result.includes(:office).paginate(page: params[:page], per_page: 10)
  end

  # GET /admins/elections/1
  # GET /admins/elections/1.json
  def show
  end

  # GET /admins/elections/new
  def new
    @admins_election = Admins::Election.new
    @admins_election.build_office
  end

  # GET /admins/elections/1/edit
  def edit
    Rails.logger.debug "NANCY: statei_id: #{@admins_election.office.state_id}"
    Rails.logger.debug "NANCY: position: #{@admins_election.office.position}"
    @admins_politicians = Admins::Politician.joins(:office).where(admins_offices: {state_id: @admins_election.office.state_id, position: Admins::Office.positions[@admins_election.office.position]})

    @incumbents = Admins::Office.where(state_id: @admins_election.office.state_id, position: Admins::Office.positions[@admins_election.office.position])
  end

  # POST /admins/elections
  # POST /admins/elections.json
  def create
    @admins_election = Admins::Election.new(admins_election_params)

    respond_to do |format|
      if @admins_election.save
        format.html { redirect_to @admins_election, notice: 'Election was successfully created.' }
        format.json { render :show, status: :created, location: @admins_election }
      else
        format.html { render :new }
        format.json { render json: @admins_election.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/elections/1
  # PATCH/PUT /admins/elections/1.json
  def update
    respond_to do |format|
      if @admins_election.update(admins_election_params)
        format.html { redirect_to @admins_election, notice: 'Election was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_election }
      else
        format.html { render :edit }
        format.json { render json: @admins_election.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/elections/1
  # DELETE /admins/elections/1.json
  def destroy
    @admins_election.destroy
    respond_to do |format|
      format.html { redirect_to admins_elections_url, notice: 'Election was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_election
      @admins_election = Admins::Election.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_election_params
      params.require(:admins_election).permit(:year, :date, :election_type, :wikipedia, :office_id, office_attributes: [ :position, :state_id, :district_id, :politician_id])
    end
end
