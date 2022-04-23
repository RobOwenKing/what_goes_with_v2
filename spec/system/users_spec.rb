require 'rails_helper'

RSpec.describe 'User account management', type: :system do
  before do
    driven_by(:rack_test)
  end

  feature 'Sign up' do
    before do
      visit new_user_registration_path
    end

    scenario 'creates account with valid params' do
      fill_in 'Email', with: 'fake@test.com'
      fill_in 'Confirm password', with: 'fakepassword'
      fill_in 'Password', with: 'fakepassword'
      fill_in 'Display name', with: 'Display me'
      click_on 'Sign up'

      expect(page).to have_content('You have signed up successfully.')
    end

    scenario 'warns user of mistakes in form' do
      fill_in 'Confirm password', with: 'OopsADaisy'
      click_on 'Sign up'

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

      @user = User.create(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        name: 'Dentarthurdent'
      )
    end

    scenario 'works with valid details' do
      click_on 'Sign in'

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_on 'Sign in'

      expect(page).to have_content('You have signed in successfully.')
    end
  end
end
