class PointEntriesController < ApplicationController
    helper_method :sort_column_entries, :sort_direction_entries
    layout 'navbar'
    def view
        @allEntries = PointEntry.order(sort_column_entries + " " + sort_direction_entries)
        @displayEntries = Array.new
        @allEntries.each do |entry|
            displayEntry = Hash.new
            displayEntry['creator'] = Officer.find(entry.officerId).name
            displayEntry['name'] = entry.name
            displayEntry['uin'] = entry.uin
            displayEntry['added'] = entry.points_add
            displayEntry['removed'] = entry.points_remove
            displayEntry['createdAt'] = entry.created_at
            displayEntry['comments'] = entry.comment
            @displayEntries.append(displayEntry)
        end
    end



  private

    def sort_column_entries
      PointEntry.column_names.include?(params[:sort]) ? params[:sort]: "uin"
    end

    def sort_direction_entries
      %w[ASC DESC].include?(params[:direction]) ? params[:direction] : "DESC"
    end
end
