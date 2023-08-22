class User < ApplicationRecord
  include UserConcern
  include SoftDelete
  
  has_secure_password
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { minimum: 3 }
  
  def login(login_params)
    @success = false
    
    @find_user = eject_deleted_data(User).find_by(email: login_params[:email])
    @is_user   = @find_user.present? && @find_user.authenticate(login_params[:password])
    
    if @is_user
      @success = true
    end
    
    return {
      success: @success,
      data: @find_user
    }
  end
  
  def current_user(user_id)
    Current.user = User.find_by(id: user_id)
  end
  
  # 戻り値 => 配列
  def list
    return format(User.all.to_a)
  end
  
  def detail(user_id)
    return format(User.find(user_id))
  end
  
  def add(user_params)
    @success = false
    
    @data = User.new(user_params)
    @save = @data.save
    if @save
      @success = true
    end

    return {
      success: @success,
      data: @data
    }
  end
  
  def edit(edit_params)
    @success = false
    
    @find_user = User.find_by(id: edit_params[:id])
    if !@find_user.nil? && @find_user.update(edit_params)
      @success = true
    end

    return @success
  end
  
  def del(user_id)
    @delete_user = nil
    
    begin
      @delete_user = User.find(user_id)
    rescue => exception
      logger.debug(exception)
      return false
    end
    
    soft_delete(User, user_id)
    
    # if !@delete_user.destroy
    #   return false
    # end
    
    return true
  end
  
end
