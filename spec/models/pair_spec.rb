require 'rails_helper'

RSpec.describe Pair, type: :model do
  describe 'associations' do
    it { should belong_to(:ingredient1).class_name('Ingredient') }
    it { should belong_to(:ingredient2).class_name('Ingredient') }
  end

  describe 'validations' do
    it { should validate_presence_of(:slug) }
  end
end
