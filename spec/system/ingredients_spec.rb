require 'rails_helper'

RSpec.describe 'Ingredients', type: :system do
  before do
    driven_by(:rack_test)
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
      fill_in 'Aka', with: @ingredient.aka
      fill_in 'Eg', with: @ingredient.eg

      click_on 'Save'

      expect(page).to have_content(@ingredient.name)
      expect(page).to_not have_content('URL slug')
    end

    scenario 'create fails with invalid inputs' do
      click_on 'Save'
      expect(page).to have_content("Name can't be blank")
    end

    scenario 'update works with valid inputs' do
      @ingredient = create(:ingredient)

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

    scenario 'posting to create does not work' do
      post '/ingredients', params: { ingredient: @ingredient, user: @user }

      visit "/ingredients/#{@ingredient.slug}"
      expect(page).to_not have_content(@ingredient.name)
    end
  end
end
