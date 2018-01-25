class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admins_post, only: [:show, :edit, :update, :destroy]

  # GET /admins/posts
  # GET /admins/posts.json
  def index
    @search = Admins::Post.ransack(params[:q])
    @admins_posts = @search.result.paginate(page: params[:page], per_page: 10)
  end

  # GET /admins/posts/1
  # GET /admins/posts/1.json
  def show
  end

  # GET /admins/posts/new
  def new
    @admins_post = Admins::Post.new
  end

  # GET /admins/posts/1/edit
  def edit
  end

  # POST /admins/posts
  # POST /admins/posts.json
  def create
    @admins_post = Admins::Post.new(admins_post_params)

    respond_to do |format|
      if @admins_post.save
        format.html { redirect_to @admins_post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @admins_post }
      else
        format.html { render :new }
        format.json { render json: @admins_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/posts/1
  # PATCH/PUT /admins/posts/1.json
  def update
    respond_to do |format|
      if @admins_post.update(admins_post_params)
        format.html { redirect_to @admins_post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_post }
      else
        format.html { render :edit }
        format.json { render json: @admins_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/posts/1
  # DELETE /admins/posts/1.json
  def destroy
    @admins_post.destroy
    respond_to do |format|
      format.html { redirect_to admins_posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admins_post
      @admins_post = Admins::Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admins_post_params
      params.require(:admins_post).permit(:social_type, :social_id, :social_date, :message, :image)
    end
end
