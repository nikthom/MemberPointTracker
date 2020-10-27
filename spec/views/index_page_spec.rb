require 'rails_helper'

RSpec.describe 'Index Page', type: :system do
    describe 'Download CSV' do
        it 'page has link' do
            visit members_path
            expect(page).to have_link("Export Data")
        end

        it 'clicks CSV download' do
            visit members_path
            click_link "Export Data"
            
        end
    end

    describe 'Download officer csv' do
        it 'has export officer link' do
            visit members_path
            expect(page).to have_link("Export Officer Data")
        end

        it 'clics export officer data' do
            visit members_path
            click_link "Export Officer Data"
        end
    end

    describe 'Log in and Add/Substract Custom Points to a memebr' do
        it 'expects a total increment of 5 in member points for John Doe' do
          visit officers_login_path
          fill_in(:email, :with => "admin@email.com")
          fill_in(:password, :with => "password")
          click_button "Log In"
          click_button "Add/Substract Points to an Officer"
          fill_in(:point_entry_uin, :with => "22")
          fill_in(:point_entry_points_add, :with => "15")
          fill_in(:point_entry_points_remove, :with => "10")
          fill_in(:point_entry_comment, :with => "No comment")
          click_button "Confirm Points Changes"
        end
      end

      describe 'Log in and Add an Officer' do
        it 'expects adding a member called Test Doe' do
          visit officers_login_path
          fill_in(:email, :with => "admin@email.com")
          fill_in(:password, :with => "password")
          click_button "Log In"
          click_button "Add an officer"
          fill_in(:officer_name, :with => "Test Doe")
          fill_in(:officer_email, :with => "whatever@tamu.edu")
          fill_in(:officer_uin, :with => "1234")
          fill_in(:officer_points, :with => "10")
          fill_in(:officer_password, :with => "password")

          click_button "Register"
          #expect(page).to have_content("Test Doe")
        end
      end

      describe 'Log in and show log for first officer' do
        it 'expect point log for first officer' do
          visit members_path
          #first('.actions').click_link("Officer Points Log")
          expect(page).to have_content("Officer Points Log")
          click_link "Officer Points Log"
        end
      end

      describe 'Log in and update first officer' do
        it 'expect point update first officer' do
          visit members_path
          #first('.actions').click_link("Officer Points Log")
          #expect(page).to have_content("Officer Points Log")
          click_link "Officer Edit"
          fill_in(:officer_name, :with => "test_updated")
          click_button "Update Officer"
        end
      end

      describe 'Log in and delete first officer' do
        it 'expect point delete first officer' do
          visit members_path
          #first('.actions').click_link("Officer Points Log")
          #expect(page).to have_content("Officer Points Log")
          click_link "Officer Delete"
          #fill_in(:officer_name, :with => "test_updated")
          click_button "Delete Officer"
        end
      end

      describe 'Log in and show details first officer' do
        it 'expect show details first officer' do
          visit members_path
          #first('.actions').click_link("Officer Points Log")
          #expect(page).to have_content("Officer Points Log")
          click_link "Officer Details"
          #fill_in(:officer_name, :with => "test_updated")
          #click_button "Update Officer"
        end
      end

      describe 'Log in then log out' do
        it 'expect log out' do
        visit officers_logout_path
        #   fill_in(:email, :with => "admin@email.com")
        #   fill_in(:password, :with => "password")
        #   click_button "Log In"
        #   sleep(3)
        #   click_link "Logout"
      end
    end

    describe 'Log in with incomplete fields' do
        it 'expects error message' do
          visit officers_login_path
          fill_in(:email, :with => "admin@email.com")
          click_button "Log In"
          
          expect(page).to have_content("Please fill in your info.")
          
        end
      end

      describe 'Log in with wrong fields' do
        it 'expects error message' do
          visit officers_login_path
          fill_in(:email, :with => "admin@email.com")
          fill_in(:password, :with => "wrong")
          click_button "Log In"
          
          expect(page).to have_content("Invalid username or password.")
          
        end
      end


    
end