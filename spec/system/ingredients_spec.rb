require 'rails_helper'

RSpec.describe 'Creating an ingredient', type: :system do
  before do
    driven_by(:rack_test)
    # @request.env["devise.mapping"] = Devise.mappings[:user]

    login_as(create(:user, { role: 'admin' }))
    @ingredient = create(:ingredient)

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
