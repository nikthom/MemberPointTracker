require 'rails_helper'

RSpec.describe 'Index Page', type: :system do
  describe 'Log in and Add a Member' do
    it 'expects adding a member called John Doe' do
      visit officers_login_path
      fill_in(:email, :with => "admin@email.com")
      fill_in(:password, :with => "password")
      click_button "Log In"
      click_button "Add a member"
      fill_in(:member_name, :with => "John Doe")
      fill_in(:member_email, :with => "whatever@tamu.edu")
      fill_in(:member_uin, :with => "123456")
      fill_in(:member_points, :with => "10")
      click_button "Add New Member"
      expect(page).to have_content("John Doe")
    end
  end

  describe 'Log in and Add/Substract Custom Points to a memebr' do
    it 'expects a total increment of 5 in member points for John Doe' do
      visit officers_login_path
      fill_in(:email, :with => "admin@email.com")
      fill_in(:password, :with => "password")
      click_button "Log In"
      click_button "Add/Substract Points"
      fill_in(:point_entry_uin, :with => "123456")
      fill_in(:point_entry_points_add, :with => "15")
      fill_in(:point_entry_points_remove, :with => "10")
      fill_in(:point_entry_comment, :with => "No comment")
      click_button "Confirm Points Changes"
      expect(page).to have_content("5")
    end
  end

  describe 'Log in and edit info for John Doe' do
    it 'expects new uin for John Doe to be 654321' do
      visit officers_login_path
      fill_in(:email, :with => "admin@email.com")
      fill_in(:password, :with => "password")
      click_button "Log In"
      click_link "Edit"
      fill_in(:member_uin, :with => "654321")
      click_button "Update Member"
      expect(page).to have_content("654321")
    end
  end

  describe 'Log in and show details of John Doe' do
    it 'expects details of John Dow' do
      visit officers_login_path
      fill_in(:email, :with => "admin@email.com")
      fill_in(:password, :with => "password")
      click_button "Log In"
      click_link "Details"
      expect(page).to have_content("Show member")
    end
  end

  describe 'Log in and delete member John Doe' do
    it 'expects details of John Dow' do
      visit officers_login_path
      fill_in(:email, :with => "admin@email.com")
      fill_in(:password, :with => "password")
      click_button "Log In"
      click_link "Delete"
      click_button "Delete Member"
      expect(page).to have_content("Manage Members")
    end
  end

end
