class Ingredient < ApplicationRecord
  has_many :pair1s, class_name: 'Pair', foreign_key: 'ingredient1_id', dependent: :destroy
  has_many :pair2s, class_name: 'Pair', foreign_key: 'ingredient2_id', dependent: :destroy

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  def pairs
    pair1s + pair2s
  end

  def self.find(input)
    input.to_i == input ? super : find_by_slug(input)
  end

  def to_param
    return nil unless persisted?

    slug
  end
end
