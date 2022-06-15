require 'rails_helper'

RSpec.describe "Posts Controller", type: :request do
 
  before(:each) do 
    @user = FactoryBot.create(:user)
    @valid_post = FactoryBot.create(:post, user_id: @user.id)
    @invalid_post = FactoryBot.create(:post, user_id: @user.id)
    sign_in(@user)
  end

  context "Post index path (logged out user)" do 
    it "GET Posts#index (logged out user), should be redirected to login page" do 
      sign_out(@user)
      get posts_path
      expect(response).to have_http_status(302)
    end
  end

  context "Post index path (logged in user)" do 
    it "GET Posts#index, should get the posts index page" do
      get posts_path
      expect(response).to have_http_status(200)
    end
  end

  context "Post show path" do 
    it "GET Posts#show, should get the post by id" do
      get post_path(@valid_post.id)
      expect(response).to have_http_status(200)
    end
  end

  context "Post new path" do 
    it "GET Posts#new, should get the new post page" do
      get new_post_path
      expect(response).to have_http_status(200)
    end
  end

  context "Post edit path" do 
    it "GET Posts#edit, should get the edit post page" do
      get edit_post_path(@valid_post.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    context "Post create path with valid attributes" do 
      it 'creates a new Post' do
        @valid_post = { id: @valid_post.id, title: @valid_post.title, description: @valid_post.description, user_id: @valid_post.user_id, status: @valid_post.status }
        expect do 
        post posts_url, params: { post: @valid_post }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the created post if post is valid' do
        @valid_post = { id: @valid_post.id, title: @valid_post.title, description: @valid_post.description, user_id: @valid_post.user_id, status: @valid_post.status }
        post posts_url, params: { post: @valid_post }
        expect(response).to have_http_status(302)
      end
    end

    context 'Post create path with invalid parameters' do
      it 'does not create a new Post' do
        expect do
          @invalid_post = { id: @invalid_post.id, title: @invalid_post.title, description: :short, user_id: @invalid_post.user_id, status: @invalid_post.status }
          post posts_url, params: { post: @invalid_post }
        end.to change(Post, :count).by(0)
      end

      it "renders an unprocessable entity code" do
        @invalid_post = { id: @invalid_post.id, title: @invalid_post.title, description: :short, user_id: @invalid_post.user_id, status: @invalid_post.status }
        post posts_url, params: { post: @invalid_post }
        expect(response).to have_http_status(422)
      end
    end
  end   

  describe 'PATCH /update' do
    context 'with valid parameters' do    
      it 'updates the requested post successfully' do
        @new_attributes = { id: @valid_post.id, title: @valid_post.title, description: "This is the new description to be updated", user_id: @invalid_post.user_id, status: @valid_post.status }
        patch post_url(@valid_post), params: { post: @new_attributes }
        expect(response).to have_http_status(302)
      end

      it "redirects upon successfull updation " do
        @valid_post = { id: @valid_post.id, title: @valid_post.title, description: @valid_post.description, user_id: @valid_post.user_id, status: @valid_post.status }
        patch post_url(@valid_post), params: { post: @valid_post }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      it "redirects upon unsuccessful updation " do
        @invalid_post = { id: @invalid_post.id, title: @invalid_post.title, description: :short, user_id: @invalid_post.user_id, status: @invalid_post.status }
        patch post_url(@valid_post), params: { post: @invalid_post }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      expect do
        delete post_url(@valid_post)
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      delete post_url(@valid_post)
      expect(response).to redirect_to(posts_url)
    end
  end

  describe 'GET /pending_posts' do
    it 'redirects to pending posts page for moderator' do
      get pending_posts_url
      expect(response).to have_http_status(200)
    end

    it 'redirects to pending posts page for normal user' do
      get pending_posts_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /set_status' do
    it 'redirects to post page' do
      patch set_status_post_path(@valid_post, status: 'reported')
      expect(response).to redirect_to(post_path(@valid_post))
    end
  end

  describe 'PATCH /publish' do
    it 'redirects to pending posts page if published' do
      patch publish_post_path(@valid_post)
      expect(response).to redirect_to(pending_posts_path)
    end

    it 'redirects to pending posts page after unsuccessful updation' do
      @invalid_post = { id: @invalid_post.id, title: @invalid_post.title, description: :short, user_id: @invalid_post.user_id, status: @invalid_post.status }
      patch publish_post_path(@invalid_post)
      expect(response).to redirect_to(pending_posts_path)
    end
  end

  describe 'PATCH /destroy' do
    it 'redirects to pending posts page if removed' do
      delete remove_post_path(@valid_post)
      expect(response).to redirect_to(pending_posts_path)
    end
  end

end
