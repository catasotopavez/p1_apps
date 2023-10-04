# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  author     :integer          not null
#  body       :text
#  public     :boolean          default(TRUE)
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trip_id    :integer
#
# Indexes
#
#  index_posts_on_author   (author)
#  index_posts_on_trip_id  (trip_id)
#
class Post < ApplicationRecord

  has_and_belongs_to_many :destinations
  belongs_to :trip
  belongs_to :author, class_name: "User", foreign_key: "author"
  has_and_belongs_to_many :users #buddies
  has_many :medias, class_name: "Media"
  has_many_attached :files
  
  def image_urls
    if files.attached?
      files.map do |file|
        Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
      end
    else
      # Return a default URL or an empty array if no images are attached.
      []
    end
  end



end
