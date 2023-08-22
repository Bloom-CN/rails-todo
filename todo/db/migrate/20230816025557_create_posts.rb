class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.string :title, null: true, limit: 50
      t.text   :context, null: true, limit: 255
      t.string :deleted_at, null: true
      t.string :user_id, null: true
      
      t.timestamps
    end
  end
end
