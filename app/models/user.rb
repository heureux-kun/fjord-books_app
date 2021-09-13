# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  # 「dependent: :destroy」でdestroyした時に関連するデータが削除される
  has_many :relationships, dependent: :destroy

  # relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスするための記述
  # source: :follow→「relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスしてね」
  has_many :followings, through: :relationships, source: :follow
  # 結果として、user.followings でフォローしているUser達を取得できる。

  # reverse_of_relationshipsという名前でアソシエーション（relationshipsの逆方向。だけどrelationsipモデルの事）外部キーはfollow_id
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy, inverse_of: :user
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    return if self == other_user

    # find_or_create_byだと保存に失敗することがあるのでcreate_or_find_by（transactionに失敗したらfind_byする）の方が良い
    # relationshipの前のselfを略している
    relationships.create_or_find_by(follow_id: other_user.id)
  end

  def unfollow(other_user)
    # relationships.find_by〜の前のselfを略している
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    # relationshipの前のselfを略している
    followings.include?(other_user)
  end
end
