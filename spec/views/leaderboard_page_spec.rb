require 'rails_helper'

RSpec.describe 'Leaderboard Page', type: :system do
    describe 'Open page' do
        it 'opens page' do
            visit leaderboard_view_path
        end
    end    

    describe 'member leaderboard' do
        it 'selects top 3 members' do
            visit leaderboard_view_path
            choose('Member')
            page.select '3', from: 'count'
            click_button "Apply"
            sleep (3)
        end

        it 'selects all members' do
            visit leaderboard_view_path
            choose('Member')
            page.select 'All', from: 'count'
            click_button "Apply"
            #sleep (3)
        end
    end

    describe 'officer leaderboard' do
        it 'selects top 3 members' do
            visit leaderboard_view_path
            choose('Officer')
            page.select '3', from: 'count'
            click_button "Apply"
            #sleep (3)
        end

        it 'selects all members' do
            visit leaderboard_view_path
            choose('Officer')
            page.select 'All', from: 'count'
            click_button "Apply"
            #sleep (3)
        end
    end
    
    describe 'member & officer leaderboard' do
        it 'selects top 3 officers' do
            visit leaderboard_view_path
            choose('Both')
            page.select '3', from: 'count'
            click_button "Apply"
            #sleep (3)
        end

        it 'selects all members and officers' do
            visit leaderboard_view_path
            choose('Both')
            page.select 'All', from: 'count'
            click_button "Apply"
            #sleep (3)
        end
    end    
end