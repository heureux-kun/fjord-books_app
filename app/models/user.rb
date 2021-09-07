# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :relationships
  # relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスするための記述
  # source: :follow→「relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスしてね」
  # 結果として、user.followings でフォローしているUser達を取得できる。
  has_many :followings, through: :relationships, source: :follow

  # reverse_of_relationshipsという名前でアソシエーション（relationshipsの逆方向。だけどrelationsipモデルの事）外部キーはfollow_id
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.create_or_find_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
