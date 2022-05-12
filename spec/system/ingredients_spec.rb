require 'rails_helper'

# CONTENTS
# Ingredients
#   search
#     finds matches in :name
#     finds matches in :aka
#     finds matches in :eg
#   show
#     has a pretty URL
#   when admin
#     create works with valid inputs
#     create fails with invalid inputs
#     update works with valid inputs
#   when non-admin user
#     new page is blocked
#     edit page is blocked

RSpec.describe 'Ingredients', type: :system do
  before do
    driven_by(:rack_test)
  end

  feature 'search' do
    before do
      @cheese = create(:ingredient)
      @courgette = create(:ingredient, name: 'Courgette', slug: 'courgette', aka: 'Zucchini', eg: '')
    end

    scenario 'finds match in :name' do
      visit root_path

      fill_in 'What goes with', with: 'chee'
      click_on 'Search'

      expect(page).to have_content(@cheese.name)
    end
  end

  feature 'show' do
    before do
      @ingredient = create(:ingredient)
    end

    scenario 'has a pretty URL' do
      visit "/ingredients/#{@ingredient.slug}"

      expect(page).to have_content(@ingredient.name)
    end
  end

  context 'when admin' do
    before do
      login_as(create(:admin))
      @ingredient = build(:ingredient)

      visit new_ingredient_path
    end

    scenario 'create works with valid inputs' do
      fill_in 'Name', with: @ingredient.name
      fill_in 'URL slug', with: @ingredient.slug
      fill_in 'Other names', with: @ingredient.aka
      fill_in 'Examples', with: @ingredient.eg

      click_on 'Save'

      expect(page).to have_content(@ingredient.name)
      expect(page).to_not have_content('URL slug')
    end

    scenario 'create fails with invalid inputs' do
      click_on 'Save'
      expect(page).to have_content("can't be blank")
    end

    scenario 'update works with valid inputs' do
      @ingredient.save!

      visit edit_ingredient_path(@ingredient)

      fill_in 'Name', with: 'Chicken'
      fill_in 'URL slug', with: 'chicken'
      click_on 'Save'

      visit '/ingredients/chicken'
      expect(page).to have_content('Chicken')
    end
  end

  context 'when non-admin user' do
    before do
      @user = create(:user)
      login_as(@user)

      @ingredient = build(:ingredient)
    end

    scenario 'new page is blocked' do
      visit new_ingredient_path

      expect(page).to_not have_content('URL slug')
    end

    scenario 'edit page is blocked' do
      @ingredient.save!
      visit edit_ingredient_path(@ingredient)

      expect(page).to_not have_content('URL slug')
    end
  end
end
