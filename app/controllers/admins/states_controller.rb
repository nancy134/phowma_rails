require 'csv'

class Admins::StatesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_state, only: [:show, :edit, :update, :destroy]

  # GET /admins/states
  # GET /admins/states.json
  def index
    Rails.logger.debug "NANCY: params:controller: #{params[:controller]}"
    @admins_states = Admins::State.all.paginate(page: params[:page], per_page: 20)
  end

  # GET /admins/states/1
  # GET /admins/states/1.json
  def show
  end

  # GET /admins/states/new
  def new
    @admins_state = Admins::State.new
  end

  # GET /admins/states/1/edit
  def edit
  end

  # POST /admins/states
  # POST /admins/states.json
  def create
    @admins_state = Admins::State.new(admins_state_params)

    respond_to do |format|
      if @admins_state.save
        format.html { redirect_to @admins_state, notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @admins_state }
      else
        format.html { render :new }
        format.json { render json: @admins_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/states/1
  # PATCH/PUT /admins/states/1.json
  def update
    respond_to do |format|
      if @admins_state.update(admins_state_params)
        format.html { redirect_to @admins_state, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_state }
      else
        format.html { render :edit }
        format.json { render json: @admins_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/states/1
  # DELETE /admins/states/1.json
  def destroy
    @admins_state.destroy
    respond_to do |format|
      format.html { redirect_to admins_states_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    Admins::State.import(params[:file])
    redirect_to action: "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_state
      @admins_state = Admins::State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_state_params
      params.require(:admins_state).permit(:name, :abbreviation)
    end
end
