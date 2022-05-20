require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'associations' do
    it { should have_many(:pairs) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }

    it { should validate_uniqueness_of(:slug) }
  end
end
