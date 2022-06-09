require 'rails_helper'

RSpec.describe "Posts", type: :request do
  fixtures :all
 
  context "GET /Posts" do 
    it "GET posts#index" do
      user = users(:regular)
      user.confirm
      sign_in user
      get posts_url
      expect(response).to have_http_status(200)
      # get root_path
      # assert_response :redirect
    end

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

end
