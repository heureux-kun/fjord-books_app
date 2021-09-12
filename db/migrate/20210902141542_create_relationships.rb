class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # user_idカラムの作成　foreign_key: trueで外部キー制約をつける
      t.references :user, foreign_key: true
      # references_idカラムの作成　foreign_key: { to_table: :users }でusersテーブルに外部キー制約をつける
      t.references :follow, foreign_key: { to_table: :users }
      t.timestamps
      
      #  user_idとfollow_idのが重複しないように
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
