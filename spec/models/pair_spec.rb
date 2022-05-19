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

  describe 'format' do
    before do
      @cheese = create(:ingredient)
      @courgette = create(:ingredient, name: 'Courgette', slug: 'courgette', aka: 'Zucchini', eg: '')

      # We need to use #create instead of #new because alphabetising of
      # ingredients happens before_validation
      @pair1 = Pair.create(ingredient1: @cheese, ingredient2: @courgette)
      @pair2 = Pair.create(ingredient1: @courgette, ingredient2: @cheese)
    end

    it 'should ensure Ingredients are in alphabetical order' do
      expect(@pair1.ingredient1.slug < @pair1.ingredient2.slug).to be_truthy
      expect(@pair2.ingredient1.slug < @pair2.ingredient2.slug).to be_truthy
    end

    it 'should generate a slug in the correct format' do
      expect(@pair1.slug).to eq('courgette-hard-cheese')
      expect(@pair2.slug).to eq('courgette-hard-cheese')
    end
  end
end
