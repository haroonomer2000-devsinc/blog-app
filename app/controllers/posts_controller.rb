class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.published.order("created_at DESC")
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  def pending 
    if current_user.role != "moderator"
      @pending_posts = current_user.posts.unpublished.order(id: :desc)
    else
      @pending_posts = Post.unpublished.order(id: :desc)
    end
  end

  def publish 
    post = Post.find(params[:id])
    post.published!
    post.published_at = Time.now
    post.save
    print(Time.now,"=",post.published_at)
    redirect_to posts_path
  end

  def unpublish 
    post = Post.find(params[:id])
    post.unpublished!
    redirect_to posts_path
  end

  def remove 
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    authorize @post  
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update

    @post = Post.find(params[:id])
    authorize @post  

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy

    @post = Post.find(params[:id])
    authorize @post  

    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :attachment, :user_id, :file)
    end
end
