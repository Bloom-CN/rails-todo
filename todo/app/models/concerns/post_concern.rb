module PostConcern
  extend ActiveSupport::Concern
  
  included do
  end
  
  def format(data)
    @result = []
    logger.info(data)
    # ORM allとfindで戻り値の型が違うので型チェック後にフォーマット
    if data.instance_of?(Array) && !data.nil?
      data.each do |post|
        if !post.deleted_at
          @result.push({
            id:         post.id.to_s,
            name:       post.name,
            title:      post.title,
            context:    post.context,
            user_id:    post.user_id,
            created_at: post.created_at.strftime('%Y/%m/%d %H:%M:%S'),
          })
        end
      end
    else
      @result = {
        id:         data.id.to_s,
        name:       data.name,
        title:      data.title,
        context:    data.context,
        user_id:    data.user_id,
        created_at: data.created_at.strftime('%Y/%m/%d %H:%M:%S'),
      }
    end
    
    return @result
  end
end
