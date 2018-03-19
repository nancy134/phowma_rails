class Admins::OfficesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_office, only: [:show, :edit, :update, :destroy]

  # GET /admins/offices
  # GET /admins/offices.json
  def index
    @search = Admins::Office.ransack(params[:q])
    @admins_offices = @search.result.paginate(page: params[:page], per_page: 10)
  end

  # GET /admins/offices/1
  # GET /admins/offices/1.json
  def show
  end

  # GET /admins/offices/new
  def new
    @admins_office = Admins::Office.new
    @admins_districts = Admins::District.all
  end

  # GET /admins/offices/1/edit
  def edit
  end

  # POST /admins/offices
  # POST /admins/offices.json
  def create
    @admins_office = Admins::Office.new(admins_office_params)

    respond_to do |format|
      if @admins_office.save
        format.html { redirect_to @admins_office, notice: 'Office was successfully created.' }
        format.json { render :show, status: :created, location: @admins_office }
      else
        format.html { render :new }
        format.json { render json: @admins_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/offices/1
  # PATCH/PUT /admins/offices/1.json
  def update
    respond_to do |format|

      if (params[:position] != Admins::Office.representative)
        params[:district_id] = nil
        if (@admins_office.district_id)
          @admins_office.district_id =nil
        end
      end

      if @admins_office.update(admins_office_params)
        format.html { redirect_to @admins_office, notice: 'Office was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_office }
      else
        format.html { render :edit }
        format.json { render json: @admins_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/offices/1
  # DELETE /admins/offices/1.json
  def destroy
    @admins_office.destroy
    respond_to do |format|
      format.html { redirect_to admins_offices_url, notice: 'Office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_office
      @admins_office = Admins::Office.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_office_params
      params.require(:admins_office).permit(:position, :state_id, :district_id, :politician_id,:politician_last_name)
    end
end
