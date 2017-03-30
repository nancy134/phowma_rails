class Admins::ElectionResultsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_election_result, only: [:show, :edit, :update, :destroy]

  # GET /admins/election_results
  # GET /admins/election_results.json
  def index
    @admins_election_results = Admins::ElectionResult.all
  end

  # GET /admins/election_results/1
  # GET /admins/election_results/1.json
  def show
  end

  # GET /admins/election_results/new
  def new
    @admins_election_result = Admins::ElectionResult.new
  end

  # GET /admins/election_results/1/edit
  def edit
  end

  # POST /admins/election_results
  # POST /admins/election_results.json
  def create
    @admins_election_result = Admins::ElectionResult.new(admins_election_result_params)

    respond_to do |format|
      if @admins_election_result.save
        format.html { redirect_to @admins_election_result, notice: 'Election result was successfully created.' }
        format.json { render :show, status: :created, location: @admins_election_result }
      else
        format.html { render :new }
        format.json { render json: @admins_election_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/election_results/1
  # PATCH/PUT /admins/election_results/1.json
  def update
    respond_to do |format|
      if @admins_election_result.update(admins_election_result_params)
        format.html { redirect_to @admins_election_result, notice: 'Election result was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_election_result }
      else
        format.html { render :edit }
        format.json { render json: @admins_election_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/election_results/1
  # DELETE /admins/election_results/1.json
  def destroy
    @admins_election_result.destroy
    respond_to do |format|
      format.html { redirect_to admins_election_results_url, notice: 'Election result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Admins::ElectionResult.import(params[:file])
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_election_result
      @admins_election_result = Admins::ElectionResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_election_result_params
      params.require(:admins_election_result).permit(:party, :election_id, :state_id)
    end
end
