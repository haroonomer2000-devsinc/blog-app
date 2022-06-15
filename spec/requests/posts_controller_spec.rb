require 'rails_helper'

RSpec.describe "Posts Controller", type: :request do
  fixtures :all
 
  before(:each) do 
    user = users(:moderator)
    user.confirm
    sign_in user
  end

  let(:valid_post) do
    {
      'id' => '4',
      'title' => "Test Post 4",
      'description' => "This is the description of post number 4", 
      'user_id'=> 707834473, 
      'status' => 0 
    }
  end
  let(:valid_post2) do
    {
      'description' => "This is the description of post number 4", 
      'user_id'=> 707834473, 
      'status' => 0 
    }
  end
  let(:invalid_post) do
    {
      'description' => "This is the description of post number 4", 
      'user_id'=> 707834473, 
      'status' => 0 
    }
  end
  let(:invalid_post2) do
    {
      'id' => '4',
      'description' => "This is description",
      'user_id'=> 707834473, 
      'status' => 0 
    }
  end

  context "Post index path (logged out user)" do 
    it "GET Posts#index (logged out user), should be redirected to login page" do 
      sign_out :user
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
      post_id = 134
      get post_path(post_id)
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
      post_id = 134
      get edit_post_path(post_id)
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST /create' do
    context "Post create path with valid attributes" do 
      it 'creates a new Post' do
        expect do post = Post.new(valid_post)
        post posts_url, params: { post: valid_post }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the created post if post is valid' do
        post posts_url, params: { post: valid_post }
        expect(response).to have_http_status(302)
      end
    end

    context 'Post create path with invalid parameters' do
      it 'does not create a new Post' do
        expect do
          post posts_url, params: { post: invalid_post }
        end.to change(Post, :count).by(0)
      end

      it "renders an unprocessable entity code" do
        post posts_url, params: { post: invalid_post }
        expect(response).to have_http_status(422)
      end
    end
  end   

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          'id' => '4',
          'title' => "Test Post 4 Updated",
          'description' => "This is the description of post number 4", 'user_id'=> 707834473, 
          'status' => 0 
        }
      end

      it 'updates the requested post successfully' do
        post = Post.new(valid_post)
        patch post_url(post), params: { post: new_attributes }
        expect(response).to have_http_status(302)
      end

    end

    context 'with invalid parameters' do
      it "redirects upon successfull updation " do
        post = Post.create! valid_post
        patch post_url(post), params: { post: valid_post }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      it "redirects upon unsuccessful updation " do
        post = Post.create! valid_post
        patch post_url(post), params: { post: invalid_post2 }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      post = Post.new(valid_post)
      post.save
      expect do
        delete post_url(post)
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      post = Post.new(valid_post)
      post.save
      delete post_url(post)
      expect(response).to redirect_to(posts_url)
    end
  end

  describe 'GET /pending_posts' do
    it 'redirects to pending posts page for moderator' do
      get pending_posts_url
      expect(response).to have_http_status(200)
    end

    it 'redirects to pending posts page for normal user' do
      user = users(:regular)
      user.confirm
      sign_in user
      get pending_posts_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH /set_status' do
    it 'redirects to post page' do
      post = Post.new(valid_post)
      post.save
      patch set_status_post_path(post, status: 'reported')
      expect(response).to redirect_to(post_path(post))
    end
  end

  describe 'PATCH /publish' do
    it 'redirects to pending posts page if published' do
      post = Post.new(valid_post)
      post.save
      patch publish_post_path(post)
      expect(response).to redirect_to(pending_posts_path)
    end

    it 'redirects to pending posts page after unsuccessful updation' do
      post = Post.new(valid_post)
      post.save
      post.description = "abc" # too short invalid
      post.save(validate: false)
      patch publish_post_path(post)
      expect(response).to redirect_to(pending_posts_path)
    end
  end

  describe 'PATCH /destroy' do
    it 'redirects to pending posts page if removed' do
      post = Post.new(valid_post)
      post.save
      delete remove_post_path(post)
      expect(response).to redirect_to(pending_posts_path)
    end
  end

end
