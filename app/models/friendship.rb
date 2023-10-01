# == Schema Information
#
# Table name: friendships
#
#  id              :integer          not null, primary key
#  gps_coordinates :string           default("{}"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  friend_id       :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_friendships_on_friend_id  (friend_id)
#  index_friendships_on_user_id    (user_id)
#
# Foreign Keys
#
#  friend_id  (friend_id => users.id)
#  user_id    (user_id => users.id)
#
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # Validaciones de unicidad y de no-autoreferencia
  validate :check_uniqueness
  validate :avoid_self_referencing

  private

  def check_uniqueness
    # Evita la duplicación (A, B) y (B, A)
    if Friendship.where(user_id: friend_id, friend_id: user_id).exists? ||
       Friendship.where(user_id: user_id, friend_id: friend_id).exists?
      errors.add(:base, "La amistad ya existe.")
    end
  end

  def avoid_self_referencing
    # Evita que un usuario sea amigo de sí mismo
    if user_id == friend_id
      errors.add(:base, "No puedes ser amigo de ti mismo.")
    end
  end
end

# Asociaciones para amistad en User
class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
end