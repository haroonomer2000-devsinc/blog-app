require 'rails_helper'

RSpec.describe "Comments Controller", type: :request do
  fixtures :all
  
  before(:each) do 
      user = users(:moderator)
      user.confirm
      sign_in user
      @post_id = 134
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

  let(:invalid_post) do
    {
      'description' => "This is the description of post number 4", 
      'user_id'=> 707834473, 
      'status' => 0 
    }
  end
  let (:valid_comment) do 
    {
        'body' => "This is test comment body",
        'user_id' => 175178709,
        'post_id' => 134,
        'parent_id' => nil
    }
  end
  
  describe 'Comments /create' do
    context "Comments create path" do 
      it 'creates a new comment with invalid attrs' do
        sign_out :user
        user = users(:regular)
        user.confirm
        sign_in user
        post = Post.find(@post_id)
        expect do 
          @comment = Comment.new(valid_comment)
          post post_comments_url(post.id), params: {body: "asasd", post: post.attributes }
        end.to change(Comment, :count).by(0)
      end
    end
  end

  describe 'Comments /update' do
    context "Comments update path with valid attributes" do 
      it 'updates a comment' do
        post = Post.find(@post_id)
        comment = Comment.new(valid_comment)
        comment.save
        patch post_comment_url(post.id,comment), params: {comment: valid_comment, post: post.attributes}
      end
    end
  end

  describe 'Comments /delete' do
    context "Comments delete path" do 
      it 'deletes a valid comment' do
        sign_out :user
        user = users(:regular)
        user.confirm
        sign_in user
        post = Post.find(@post_id)
        comment = Comment.new(valid_comment)
        comment.save
        expect do
            delete post_comment_url(post.id,comment), params: {comment: valid_comment, post: post.attributes }
        end.to change(Comment, :count).by(-1)
      end

      it 'deletes a comment with invalid id resource not found' do
        sign_out :user
        user = users(:regular)
        user.confirm
        sign_in user
        post = Post.find(@post_id)
        comment = Comment.new(valid_comment)
        comment.save
        comment.id = 123123 #invalid id
        delete post_comment_url(post.id,comment), params: {comment: comment, post: post.attributes }
        expect(response).to have_http_status(302)
      end
    end
  end


end
