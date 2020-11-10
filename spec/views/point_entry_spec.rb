require 'rails_helper'

RSpec.describe 'Point Log Page', type: :system do
    describe 'Download CSV' do
        it 'goes to page and clicks download link' do
            visit point_entries_view_path
            click_link "Name"
            click_link "Export Custom Point Entry Data"
        end
    end
end