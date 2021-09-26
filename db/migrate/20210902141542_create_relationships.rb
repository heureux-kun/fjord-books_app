# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # user_idカラムの作成　foreign_key: trueで外部キー制約をつける
      t.references :user, foreign_key: true
      # references_idカラムの作成　foreign_key: { to_table: :users }でusersテーブルに外部キー制約をつける
      t.references :follow, foreign_key: { to_table: :users }
      t.timestamps

      # user_idとfollow_idのが重複しないように
      # MEMO：なぜこれでuser_idとfollow_idの組み合わせが一意になるのか分からない（indexとどう関係あるのか？）
      # MEMO：t.index %i(user_id follow_id)〜にしていると、rubocopに「[Correctable] Style/PercentLiteralDelimiters: %i-literals should be delimited by [ and ].」言われたので、%i[user_id follow_id]にしたが、なぜこの書き方が良いのか分からない
      t.index %i[user_id follow_id], unique: true
    end
  end
end
