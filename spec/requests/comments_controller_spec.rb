require 'rails_helper'

RSpec.describe "Comments Controller", type: :request do
  
  before(:each) do 
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:user)
    @valid_post = FactoryBot.create(:post, user_id: @user.id)
    @valid_comment = FactoryBot.create(:comment, user_id: @user.id, post_id: @valid_post.id, parent_id: nil)
    sign_in(@user)
  end
  
  describe 'Comments /create' do
    context "Comments create path" do 
      it 'creates a new comment with valid attrs' do
        @new_body = "This is a new body"
        post post_comments_url(@valid_post.id), params: { "post" => {body: @new_body, parent_id: nil} , post: @valid_post.attributes }
        expect(Comment.last.body).to eq(@new_body)
      end

      it 'does not create a new comment with invalid attrs' do
        expect do 
          post post_comments_url(@valid_post.id), params: { "post" => {body: nil, parent_id: nil} , post: @valid_post.attributes }
        end.to change(Comment, :count).by(0)
      end
    end
  end

  describe 'Comments /update' do
    context "Comments update path with valid attributes" do 
      it 'updates a comment' do
        sign_in(@second_user)
        @valid_comment_hash = { id: @valid_comment.id, body: @valid_comment.body, post_id: @valid_post.id, user_id: @user.id, parent_id: nil}
        patch post_comment_url(@valid_post.id,@valid_comment.id), params: {post: @valid_post.attributes}
        expect(response).to redirect_to(post_path(@valid_post.id))
      end
    end
    context "Comments update path with invalid attributes" do 
      it 'updates a comment with invalid attributes' do
        sign_in(@second_user)
        @valid_comment_hash = { id: @valid_comment.id, body: @valid_comment.body, post_id: @valid_post.id, user_id: @user.id, parent_id: nil}
        patch post_comment_url(@valid_post.id, 123), params: {post: @valid_post.attributes}
        expect(response).to redirect_to(posts_path)
      end
    end
  end

  describe 'Comments /delete' do
    context "Comments delete path" do 
      it 'deletes a valid comment' do
        expect do
            delete post_comment_url(@valid_post.id,@valid_comment), params: {comment: @valid_comment, post: @valid_post.attributes }
        end.to change(Comment, :count).by(-1)
      end
    end
  end

end
