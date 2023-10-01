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
require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
