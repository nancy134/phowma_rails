class Api::V1::PostsController < Api::V1::BaseController
  def index
    posts = Admins::Post.all
    render json: posts, each_serializer: Api::V1::PostSerializer
  end
end

