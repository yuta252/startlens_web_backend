class ExhibitFavorite < ApplicationRecord
  validates :exhibit_id, presence: true
  validates :tourist_id, presence: true, uniqueness: { scope: [:exhibit_id]}

  belongs_to :exhibit
  belongs_to :user
end
