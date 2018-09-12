class Admins::MessagesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_message, only: [:show, :edit, :update, :destroy]

  # GET /admins/messages
  # GET /admins/messages.json
  def index
    @search = Admins::Message.ransack(params[:q])
    @admins_messages = @search.result.paginate(page: params[:page], per_page: 10)
  end

  # GET /admins/messages/1
  # GET /admins/messages/1.json
  def show
  end

  # GET /admins/messages/new
  def new
    @admins_message = Admins::Message.new
  end

  # GET /admins/messages/1/edit
  def edit
  end

  # POST /admins/messages
  # POST /admins/messages.json
  def create
    @admins_message = Admins::Message.new(admins_message_params)

    respond_to do |format|
      if @admins_message.save
        format.html { redirect_to @admins_message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @admins_message }
      else
        format.html { render :new }
        format.json { render json: @admins_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/messages/1
  # PATCH/PUT /admins/messages/1.json
  def update
    respond_to do |format|
      if @admins_message.update(admins_message_params)
        format.html { redirect_to @admins_message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_message }
      else
        format.html { render :edit }
        format.json { render json: @admins_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/messages/1
  # DELETE /admins/messages/1.json
  def destroy
    @admins_message.destroy
    respond_to do |format|
      format.html { redirect_to admins_messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_message
      @admins_message = Admins::Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_message_params
      params.require(:admins_message).permit(:name, :email, :message)
    end
end
