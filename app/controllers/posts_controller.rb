# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy publish remove set_status]

  # GET /posts or /posts.json
  def index
    @posts = Post.PUBLISHED.active.order(id: :desc).includes(:user).page(params[:page]).per(4)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1 or /posts/1.json
  def show
    redirect_to posts_path if @post.report_status == 'hidden'
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    authorize @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: I18n.t(:post_create) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: I18n.t(:post_update) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: I18n.t(:post_destroy) }
    end
  end

  def set_status
    @post.report_status = params[:status]
    flash[:alert] = @suggestion.errors.full_messages.to_sentence unless @post.save
    redirect_to post_path(params[:id])
  end

  def pending
    @pending_posts = if current_user.role == 'moderator'
                       Post.UNPUBLISHED.order(id: :desc).includes(:user).page(params[:page]).per(4)
                     else
                       current_user.posts.UNPUBLISHED.order(id: :desc).includes(:user).page(params[:page]).per(4)
                     end
  end

  def publish
    @post.publish_post
    flash[:alert] = if @post.save
                      I18n.t(:post_published)
                    else
                      @post.errors.full_messages.to_sentence
                    end
    redirect_to pending_posts_path
  end

  def remove
    flash[:alert] = if @post.destroy
                      I18n.t(:post_destroy)
                    else
                      @post.errors.full_messages.to_sentence
                    end
    redirect_to pending_posts_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by(id: params[:id])
    return unless @post.nil?

    flash[:notice] = I18n.t(:resource_not_found)
    redirect_to posts_path
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :description, :user_id, files: [])
  end
end
