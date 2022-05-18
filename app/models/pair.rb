class Pair < ApplicationRecord
  belongs_to :ingredient1, class_name: 'Ingredient'
  belongs_to :ingredient2, class_name: 'Ingredient'

  validates :ingredient1, uniqueness: { scope: :ingredient2 }
  # Validating in one direction should be enough!
  # validates :ingredient2, uniqueness: { scope: :ingredient1 }

  validates :slug, presence: true

  def self.find(input)
    input.to_i == input ? super : find_by_slug(input)
  end

  def to_param
    return nil unless persisted?

    slug
  end
end
