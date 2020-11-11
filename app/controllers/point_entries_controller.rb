class PointEntriesController < ApplicationController
    helper_method :sort_column_entries, :sort_direction_entries
    layout 'navbar'
    def view
        @allEntries = PointEntry.order(sort_column_entries + " " + sort_direction_entries)
        @displayEntries = Array.new
        @allEntries.each do |entry|
            shouldDisplay = TRUE
            displayEntry = Hash.new
            if Officer.exists?(id: entry.officerId)
              displayEntry['creator'] = Officer.find(entry.officerId).name
            else
              shouldDisplay = FALSE
            end
            displayEntry['name'] = entry.name
            if Member.exists?(uin: entry.uin)
              displayEntry['uin'] = entry.uin
            else
              shouldDisplay = FALSE
            end
            displayEntry['added'] = entry.points_add
            displayEntry['removed'] = entry.points_remove
            displayEntry['createdAt'] = entry.created_at.to_formatted_s(:custom)
            displayEntry['comments'] = entry.comment
            if shouldDisplay
              @displayEntries.append(displayEntry)
            else
              entry.destroy
            end
        end
    end

    def index 
      @pointEntry = PointEntry.order(:created_at => "desc")
      respond_to do |format|
        format.csv {send_data @pointEntry.to_csv, filename: "custom-point-entries-#{Date.today}.csv" }
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