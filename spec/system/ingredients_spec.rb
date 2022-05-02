require 'rails_helper'

RSpec.describe 'Ingredients', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Viewing an ingredient' do
    before do
      @ingredient = create(:ingredient)
    end

    scenario 'has a pretty URL' do
      visit "/ingredients/#{@ingredient.slug}"

      expect(page).to have_content(@ingredient.name)
    end
  end

  describe 'Creating an ingredient' do
    before do
      login_as(create(:admin))
      @ingredient = build(:ingredient)

      visit new_ingredient_path
    end

    scenario 'it works with valid inputs' do
      fill_in 'Name', with: @ingredient.name
      fill_in 'URL slug', with: @ingredient.slug
      fill_in 'Aka', with: @ingredient.aka
      fill_in 'Eg', with: @ingredient.eg

      click_on 'Save'

      expect(page).to have_content(@ingredient.name)
      # Test for presence of "Add comment" to prove we're on an Ingredient show page
      expect(page).to have_content('Add comment')
    end

    scenario 'it fails with invalid inputs' do
      click_on 'Save'
      expect(page).to have_content("Name can't be blank")
    end
  end
end
