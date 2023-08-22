module SoftDelete
  
  # 論理削除でカスタムが必要な時は改めて関数作成する
  def eject_deleted_data(model)
    return model.where(deleted_at: nil)
  end
  
  def soft_delete(model, data_id)
    @success = false
    
    @find_user = model.find_by(id: data_id)
    
    if !@find_user.nil? && @find_user.update({deleted_at: Time.zone.now})
      @success = true
    end

    return @success
  end
  
end
