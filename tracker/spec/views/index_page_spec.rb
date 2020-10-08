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
end