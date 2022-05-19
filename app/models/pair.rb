class Pair < ApplicationRecord
  belongs_to :ingredient1, class_name: 'Ingredient'
  belongs_to :ingredient2, class_name: 'Ingredient'

  before_validation :alphabetise_ingredients, :create_slug

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

  private

  def alphabetise_ingredients
    return if ingredient1.slug < ingredient2.slug

    temp = ingredient2
    self.ingredient2 = ingredient1
    self.ingredient1 = temp
  end

  def create_slug
    self.slug = "#{ingredient1.slug}-#{ingredient2.slug}"
  end
end
