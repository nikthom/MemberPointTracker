class PointEntriesController < ApplicationController    
    layout 'navbar'
    def view
        @allEntries = PointEntry.order(created_at: :desc).all
        @displayEntries = Array.new
        @allEntries.each do |entry|
            displayEntry = Hash.new
            displayEntry['creator'] = Officer.find(entry.officerId).name
            displayEntry['name'] = Member.find_by_uin(entry.uin).name
            displayEntry['uin'] = entry.uin
            displayEntry['added'] = entry.points_add
            displayEntry['removed'] = entry.points_remove
            displayEntry['createdAt'] = entry.created_at
            @displayEntries.append(displayEntry)
        end
    end
end 