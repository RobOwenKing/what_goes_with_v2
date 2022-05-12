require 'rails_helper'

# CONTENTS
# User account management
#   Sign up
#     creates account with valid params
#     warns user of mistakes in form
# User authentication
#   Sign in
#     works with valid details

RSpec.describe 'User account management', type: :system do
  before do
    driven_by(:rack_test)
  end

  feature 'Sign up' do
    before do
      visit new_user_registration_path
    end

    scenario 'creates account with valid params' do
      @user = build(:user)

      fill_in 'Email', with: @user.email
      fill_in 'Confirm password', with: @user.password
      fill_in 'Password', with: @user.password
      fill_in 'Display name', with: @user.name
      click_on 'Submit'

      expect(page).to have_content('You have signed up successfully.')
    end

    scenario 'warns user of mistakes in form' do
      fill_in 'Confirm password', with: 'OopsADaisy'
      click_on 'Submit'

      expect(page).to have_content('Please provide a valid email')
      expect(page).to have_content('Passwords must match')
      expect(page).to have_content('Please provide a display name')
    end
  end
end

RSpec.describe 'User authentication', type: :system do
  before do
    driven_by(:rack_test)
  end

  feature 'Sign in' do
    before do
      visit root_path

      @user = create(:user)
    end

    scenario 'works with valid details' do
      click_on 'Sign in'

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_on 'Submit'

      expect(page).to have_text('Signed in successfully')
      expect(page).to have_link('Sign out')
      expect(page).to have_no_link('Sign in')
    end
  end
end
