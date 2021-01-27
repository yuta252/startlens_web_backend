class ExhibitFavorite < ApplicationRecord
  validates :exhibit_id, presence: true
  validates :tourist_id, presence: true, uniqueness: { scope: [:exhibit_id], message: "既にお気に入り登録されています。" }

  belongs_to :exhibit
  belongs_to :tourist
end
