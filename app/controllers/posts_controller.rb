class PostsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_post, only: %i[ destroy ]

  def index
    @posts =
      if logged_in?
        Post.all
      else
        Post.where(hidden: false)
      end

    @posts = @posts.order(created_at: :asc).all
    @new_post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.ip_address = request.remote_ip

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url(anchor: dom_id(@post)), notice: "Created!" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.hidden = !@post.hidden
    @post.save!

    msg =
      if @post.hidden
        "Destruido :3"
      else
        "Restaurado :3"
      end

    respond_to do |format|
      format.html { redirect_to posts_url(anchor: dom_id(@post)), notice: msg }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :author)
    end
end
