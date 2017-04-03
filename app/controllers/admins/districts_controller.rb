class Admins::DistrictsController < ApplicationController
  before_action :set_admins_district, only: [:show, :edit, :update, :destroy]

  # GET /admins/districts
  # GET /admins/districts.json
  def index
    @admins_districts = Admins::District.all
  end

  # GET /admins/districts/1
  # GET /admins/districts/1.json
  def show
  end

  # GET /admins/districts/new
  def new
    @admins_district = Admins::District.new
  end

  # GET /admins/districts/1/edit
  def edit
  end

  # POST /admins/districts
  # POST /admins/districts.json
  def create
    @admins_district = Admins::District.new(admins_district_params)

    respond_to do |format|
      if @admins_district.save
        format.html { redirect_to @admins_district, notice: 'District was successfully created.' }
        format.json { render :show, status: :created, location: @admins_district }
      else
        format.html { render :new }
        format.json { render json: @admins_district.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/districts/1
  # PATCH/PUT /admins/districts/1.json
  def update
    respond_to do |format|
      if @admins_district.update(admins_district_params)
        format.html { redirect_to @admins_district, notice: 'District was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_district }
      else
        format.html { render :edit }
        format.json { render json: @admins_district.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/districts/1
  # DELETE /admins/districts/1.json
  def destroy
    @admins_district.destroy
    respond_to do |format|
      format.html { redirect_to admins_districts_url, notice: 'District was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Admins::District.import(params[:file])
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_district
      @admins_district = Admins::District.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_district_params
      params.require(:admins_district).permit(:name, :state_id)
    end
end
