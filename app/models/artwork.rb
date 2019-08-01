# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorite   :boolean
#

class Artwork < ApplicationRecord
  validates :title, :image_url, :artist_id, presence: true
  validates :artist_id, uniqueness: { scope: :title }

  belongs_to :artist,
    foreign_key: :artist_id,
    class_name: 'User'

  has_many :shares,
    foreign_key: :artwork_id,
    class_name: 'ArtworkShare'

  has_many :shared_viewers,
    through: :shares,
    source: :viewer

  has_many :comments,
    foreign_key: :artwork_id,
    class_name: "Comment",
    dependent: :destroy

  has_many :likes, as: :like

  has_many :likers,
    through: :likes,
    source: :user

  has_many :collection_items,
    foreign_key: :artwork_id,
    class_name: 'CollectionItem'
end
