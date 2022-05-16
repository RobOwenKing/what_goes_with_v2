class Pair < ApplicationRecord
  belongs_to :ingredient1, class_name: 'Ingredient'
  belongs_to :ingredient2, class_name: 'Ingredient'

  validates :ingredient1, uniqueness: { scope: :ingredient2 }
  validates :ingredient2, uniqueness: { scope: :ingredient1 }

  validates :slug, presence: true
end
