class Admins::ZipsController < ApplicationController
  before_action :set_admins_zip, only: [:show, :edit, :update, :destroy]

  # GET /admins/zips
  # GET /admins/zips.json
  def index
    @admins_zips = Admins::Zip.all
  end

  # GET /admins/zips/1
  # GET /admins/zips/1.json
  def show
  end

  # GET /admins/zips/new
  def new
    @admins_zip = Admins::Zip.new
  end

  # GET /admins/zips/1/edit
  def edit
  end

  # POST /admins/zips
  # POST /admins/zips.json
  def create
    @admins_zip = Admins::Zip.new(admins_zip_params)

    respond_to do |format|
      if @admins_zip.save
        format.html { redirect_to @admins_zip, notice: 'Zip was successfully created.' }
        format.json { render :show, status: :created, location: @admins_zip }
      else
        format.html { render :new }
        format.json { render json: @admins_zip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/zips/1
  # PATCH/PUT /admins/zips/1.json
  def update
    respond_to do |format|
      if @admins_zip.update(admins_zip_params)
        format.html { redirect_to @admins_zip, notice: 'Zip was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_zip }
      else
        format.html { render :edit }
        format.json { render json: @admins_zip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/zips/1
  # DELETE /admins/zips/1.json
  def destroy
    @admins_zip.destroy
    respond_to do |format|
      format.html { redirect_to admins_zips_url, notice: 'Zip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_zip
      @admins_zip = Admins::Zip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_zip_params
      params.require(:admins_zip).permit(:code)
    end
end
