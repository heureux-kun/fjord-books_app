class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # user_idカラムの作成　foreign_key: trueで外部キー制約をつける
      t.references :user, foreign_key: true, index: {unique: true}
      # references_idカラムの作成　foreign_key: { t_table: :users }でusersテーブルに外部キー制約をつける
      t.references :follow, foreign_key: { t_table: :users }, index: {unique: true}
      t.timestamps
    end
  end
end
