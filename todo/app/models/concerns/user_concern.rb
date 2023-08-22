module UserConcern
  extend ActiveSupport::Concern
  
  included do
  end
  
  def format(data)
    @result = []
    
    # ORM allとfindで戻り値の型が違うので型チェック後にフォーマット
    if data.instance_of?(Array) && !data.nil?
      data.each do |user|
        if !user.deleted_at
          @result.push({
            id:         user.id.to_s,
            name:       user.name,
            email:      user.email,
            created_at: user.created_at.strftime('%Y/%m/%d %H:%M:%S'),
          })
        end
      end
    else
      @result = {
        id:         data.id.to_s,
        name:       data.name,
        email:      data.email,
        created_at: data.created_at.strftime('%Y/%m/%d %H:%M:%S'),
      }
    end
    
    return @result
  end
end
