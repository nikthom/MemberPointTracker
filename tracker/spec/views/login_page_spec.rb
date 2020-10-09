require 'rails_helper'

RSpec.describe 'Log in page', type: :system do
  describe 'Go to  log in page' do
    it 'expects page to prompt user to' do
      visit officers_login_path
      expect(page).to have_content('Login')
    end
  end

  describe 'has form' do
    it 'promots users for email and password' do
      visit officers_login_path
      expect(page).to have_selector('form')
      expect(page).to have_field('email')
      expect(page).to have_field('password')
    end
  end

  describe 'user enters invalid credentials' do
    it 'returns error message' do
      visit officers_login_path
      fill_in(:email, with: 'invalid@email.com')
      fill_in(:password, with: 'wrongpassword')
      click_button 'Log in'
      expect(page).to have_content('Invalid username or password.')
    end
  end

  describe 'user enters valid credentials' do
    it 'accepts login and enters manage members page' do
      visit officers_login_path
      fill_in(:email, with: 'admin@email.com')
      fill_in(:password, with: 'password')
      click_button 'Log in'
      expect(page).to have_content('Manage Members')
    end
  end

  describe 'user wants to create an account' do
    it 'shows Create an Account page' do
      visit officers_login_path
      expect(page).to have_selector(:link_or_button, 'Create an Account')
      click_button 'Create an Account'
      expect(page).to have_content('Create an Account')
    end
  end

  describe 'user creates a new account and logs in with credentials' do
    it 'shows manage members page' do
      visit officers_login_path
      click_button 'Create an Account'
      # sleep(3)
      expect(page).to have_content('Create an Account')
      expect(page).to have_field('officer[name]')

      fill_in(:officer_name, with: 'Capybara Test')
      fill_in(:officer_email, with: 'cTest@email.com')
      fill_in(:officer_uin, with: '3')
      fill_in(:officer_password, with: 'password')

      click_button 'Register'

      sleep(1)
      fill_in(:email, with: 'cTest@email.com')
      fill_in(:password, with: 'password')
      click_button 'Log in'
      expect(page).to have_content('Manage Members')
    end
  end
end
