class Admins::AreaCodesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_area_code, only: [:show, :edit, :update, :destroy]

  # GET /admins/area_codes
  # GET /admins/area_codes.json
  def index
    @admins_area_codes = Admins::AreaCode.all.paginate(page: params[:page], per_page: 20)
  end

  # GET /admins/area_codes/1
  # GET /admins/area_codes/1.json
  def show
  end

  # GET /admins/area_codes/new
  def new
    @admins_area_code = Admins::AreaCode.new
  end

  # GET /admins/area_codes/1/edit
  def edit
  end

  # POST /admins/area_codes
  # POST /admins/area_codes.json
  def create
    @admins_area_code = Admins::AreaCode.new(admins_area_code_params)

    respond_to do |format|
      if @admins_area_code.save
        format.html { redirect_to @admins_area_code, notice: 'Area code was successfully created.' }
        format.json { render :show, status: :created, location: @admins_area_code }
      else
        format.html { render :new }
        format.json { render json: @admins_area_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/area_codes/1
  # PATCH/PUT /admins/area_codes/1.json
  def update
    respond_to do |format|
      if @admins_area_code.update(admins_area_code_params)
        format.html { redirect_to @admins_area_code, notice: 'Area code was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_area_code }
      else
        format.html { render :edit }
        format.json { render json: @admins_area_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/area_codes/1
  # DELETE /admins/area_codes/1.json
  def destroy
    @admins_area_code.destroy
    respond_to do |format|
      format.html { redirect_to admins_area_codes_url, notice: 'Area code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Admins::AreaCode.import(params[:file])
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_area_code
      @admins_area_code = Admins::AreaCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_area_code_params
      params.require(:admins_area_code).permit(:code, :state_id)
    end
end
