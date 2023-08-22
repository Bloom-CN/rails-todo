class PostsController < ApplicationController
  POST_DETAIL = "/posts" + LinkConfig::LINKS[:post_detail] + "/"
  
  def index
    @post_model       = Post.new
    @post_list        = @post_model.list
    @link_post_detail = POST_DETAIL
  end
  
  def new
    @post_model = Post.new
    @user_data  = get_user
  end
  
  def show
    @post_model      = Post.new
    @post_detail     = @post_model.detail(params[:id])
    @allow_edit_post = @post_detail[:user_id] === get_user[:id]
  end
  
  def create
    @post_model = Post.new
    @result     = @post_model.add(post_params)
    @user_data  = get_user
    
    if @result[:success]
      flash[configs[:success]] = configs[:flash_ok]
      redirect_to root_path
    else
      @post_model = @result[:data]
      flash.now[configs[:failed]] = configs[:flash_failed]
      render :new, status: :unprocessable_entity
    end
    
  end
  
  def edit
    @post_model  = Post.new
    @post_detail = @post_model.detail(params[:id])
    @user_data   = get_user
  end
  
  def update
    @post_model  = Post.new
    @post_detail = @post_model.detail(params[:id])
    @user_data   = get_user
    
    if @post_model.edit_post(edit_params)
      flash[configs[:success]] = configs[:edit_ok]
      redirect_to action: :show
    else
      flash.now[configs[:failed]] = configs[:edit_failed]
      render :edit, status: :unprocessable_entity
    end
  end
  
  def delete
    @post_model  = Post.new
    @post_detail = @post_model.detail(params[:id])
    
    if @post_model.del(params[:id])
      flash[configs[:success]] = configs[:delete_ok]
      redirect_to action: :index
    else
      flash.now[configs[:failed]] = configs[:delete_failed]
      render :show, status: :unprocessable_entity
    end
    
  end
  
  private
  
  def post_params
    params.require(:post).permit(:user_id, :name, :title, :context)
  end
  
  def edit_params
    params.require(:post).permit(:id, :title, :context)
  end
  
  def configs
    return {
      # STATUS
      success: SessionConfig::NAMES[:success],
      failed: SessionConfig::NAMES[:failed],
      
      # TEXT
      flash_ok: PostConfig::FLASH[:post_ok],
      flash_failed: PostConfig::FLASH[:post_failed],
      
      edit_ok: PostConfig::FLASH[:edit_ok],
      edit_failed: PostConfig::FLASH[:edit_failed],
      
      delete_ok: PostConfig::FLASH[:delete_ok],
      delete_failed: PostConfig::FLASH[:delete_failed],
    }
  end
  
  def get_user
    @user_id     = get_session[:USER_ID]
    @user_model  = User.new
    @user_detail = @user_model.detail(@user_id)
    
    return {
      id: @user_detail[:id],
      name: @user_detail[:name]
    }
  end
  
end
