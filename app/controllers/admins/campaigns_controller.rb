class Admins::CampaignsController < ApplicationController
  before_action :set_admins_campaign, only: [:show, :edit, :update, :destroy]

  # GET /admins/campaigns
  # GET /admins/campaigns.json
  def index
    @admins_campaigns = Admins::Campaign.all
  end

  # GET /admins/campaigns/1
  # GET /admins/campaigns/1.json
  def show
  end

  # GET /admins/campaigns/new
  def new
    @admins_campaign = Admins::Campaign.new
  end

  # GET /admins/campaigns/1/edit
  def edit
  end

  # POST /admins/campaigns
  # POST /admins/campaigns.json
  def create
    @admins_campaign = Admins::Campaign.new(admins_campaign_params)

    respond_to do |format|
      if @admins_campaign.save
        format.html { redirect_to @admins_campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @admins_campaign }
      else
        format.html { render :new }
        format.json { render json: @admins_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/campaigns/1
  # PATCH/PUT /admins/campaigns/1.json
  def update
    respond_to do |format|
      if @admins_campaign.update(admins_campaign_params)
        format.html { redirect_to @admins_campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_campaign }
      else
        format.html { render :edit }
        format.json { render json: @admins_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/campaigns/1
  # DELETE /admins/campaigns/1.json
  def destroy
    @admins_campaign.destroy
    respond_to do |format|
      format.html { redirect_to admins_campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_campaign
      @admins_campaign = Admins::Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_campaign_params
      params.require(:admins_campaign).permit(:politician_id, :election_id)
    end
end
