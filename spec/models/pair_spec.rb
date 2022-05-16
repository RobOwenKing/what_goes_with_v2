require 'rails_helper'

RSpec.describe Pair, type: :model do
  describe 'associations' do
    it { should belong_to(:ingredient1).class_name('Ingredient') }
    it { should belong_to(:ingredient2).class_name('Ingredient') }
  end

  describe 'validations' do
    # @todo Explore how below tests should be done!
    # it { should validate_uniqueness_of(:ingredient1).scoped_to(:ingredient2) }
    # it { should validate_uniqueness_of(:ingredient2).scoped_to(:ingredient1) }

    it { should validate_presence_of(:slug) }
  end
end
