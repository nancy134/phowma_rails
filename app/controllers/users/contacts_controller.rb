class Users::ContactsController < ApplicationController
  before_action :set_users_contact, only: [:show, :edit, :update, :destroy]

  # GET /users/contacts
  # GET /users/contacts.json
  def index
    @users_contacts = Users::Contact.all
  end

  # GET /users/contacts/1
  # GET /users/contacts/1.json
  def show
  end

  # GET /users/contacts/new
  def new
    @users_contact = Users::Contact.new
  end

  # GET /users/contacts/1/edit
  def edit
  end

  # POST /users/contacts
  # POST /users/contacts.json
  def create
    @users_contact = Users::Contact.new(users_contact_params)

    respond_to do |format|
      if @users_contact.save
        format.html { redirect_to @users_contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @users_contact }
      else
        format.html { render :new }
        format.json { render json: @users_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/contacts/1
  # PATCH/PUT /users/contacts/1.json
  def update
    respond_to do |format|
      if @users_contact.update(users_contact_params)
        format.html { redirect_to @users_contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @users_contact }
      else
        format.html { render :edit }
        format.json { render json: @users_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/contacts/1
  # DELETE /users/contacts/1.json
  def destroy
    @users_contact.destroy
    respond_to do |format|
      format.html { redirect_to users_contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_users_contact
      @users_contact = Users::Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_contact_params
      params.require(:users_contact).permit(:phone_id)
    end
end
