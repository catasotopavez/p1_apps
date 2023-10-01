# == Schema Information
#
# Table name: trip_destinations
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  destination_id :integer
#  trip_id        :integer
#
# Indexes
#
#  index_trip_destinations_on_destination_id  (destination_id)
#  index_trip_destinations_on_trip_id         (trip_id)
#
class TripDestination < ApplicationRecord
    belongs_to :trip
    belongs_to :destination
end
