class Pair < ApplicationRecord
  belongs_to :ingredient1, class_name: 'Ingredient'
  belongs_to :ingredient2, class_name: 'Ingredient'
end
