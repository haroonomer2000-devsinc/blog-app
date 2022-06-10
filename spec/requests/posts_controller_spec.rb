require 'rails_helper'

RSpec.describe "Posts Controller", type: :request do
  fixtures :all
 
  before(:each) do 
    user = users(:regular)
    user.confirm
    sign_in user
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
      post_id = 1
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
      post_id = 1
      get edit_post_path(post_id)
      expect(response).to have_http_status(200)
    end
  end

  let(:valid_post) do
    {
      'title' => "Test Post 3",
      'description' => "This is the description of post number 2", 'user_id'=> 175178709, 
      'status' => 0 
    }
  end

  let(:invalid_post) do
    {
      'description' => "This is the description of post number 2", 'user_id'=> 175178709, 
      'status' => 0 
    }
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

    
    # assert_response :redirect
    # it "ensures title present" do 
    #   sign_in temp
    #   get new_post_path
    #   post = Post.new(title: "ABBABABBAC",description: "VCVVCVCVCVVCVVCVCVCVCVCVVCVCVCVCVCVVCVCVCVCVCVVCVCVCVCVCVVCVCVCVCC", user_id: 30, status: 0).save
    #   expect(post).to eq(true)
    # end
  #   it "gets posts index" do 
  #     sign_out :user
  #     sign_in users(:regular)
  #     get posts_path 
  #     assert_response :success
  #   end

end
