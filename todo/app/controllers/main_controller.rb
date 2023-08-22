class MainController < ApplicationController
  POST_DETAIL = "posts" + LinkConfig::LINKS[:post_detail] + "/"
  
  def index
    @post_data        = own_posts
    @link_post_detail = POST_DETAIL
  end
  
  private
  
  def get_posts
    @post_model = Post.new
    return @post_model.list
  end
  
  def own_posts
    @post_model = Post.new
    return @post_model.own_list(get_session[:USER_ID])
  end
  
end
