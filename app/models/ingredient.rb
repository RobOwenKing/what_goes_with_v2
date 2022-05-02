class Ingredient < ApplicationRecord
  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  def to_param
    return nil unless persisted?

    slug
  end

  def self.find(input)
    input.to_i == input ? super : find_by_slug(input)
  end
end
