class Post < ApplicationRecord
  include SoftDelete
  include PostConcern
  
  validates :name, presence: true, uniqueness: false, length: { minimum: 3 }
  validates :title, presence: true, length: { maximum: 50 }
  validates :context, presence: false, length: { maximum: 255 }
  validates :user_id, presence: true
  
  def list
    return format(
      eject_deleted_data(Post).all.to_a
    )
  end
  
  def own_list(user_id)
    @own_posts = Post.where(user_id: user_id)
    return format(@own_posts.to_a)
  end
  
  def detail(post_id)
    return format(Post.find(post_id))
  end
  
  def add(post_params)
    @success = false
    
    @data = Post.new(post_params)
    @save = @data.save
    if @save
      @success = true
    end
    
    return {
      success: @success,
      data: @data
    }
  end
  
  def edit_post(edit_params)
    @success = false
    @find_post = Post.find_by(id: edit_params[:id])
    if !@find_post.nil? && @find_post.update(edit_params)
      @success = true
    end

    return @success
  end
  
  def del(post_id)
    
    begin
      Post.find(post_id)
    rescue => exception
      logger.debug(exception)
      return false
    end
    
    soft_delete(Post, post_id)
    
    return true
  end
  
end
