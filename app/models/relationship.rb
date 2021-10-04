# frozen_string_literal: true

class Relationship < ApplicationRecord
  # user_idと関連付けるので、belongs_to :user
  belongs_to :user

  # follow_idと関連付けるので、belongs_to :follow
  # Followクラスという存在しないクラスを参照することを防ぐため、Userクラスであることを明示
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true, uniqueness: { scope: :user }
end
