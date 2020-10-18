class PointEntriesController < ApplicationController
def new
  @point_entries = PointEntry.new
end

def create
  @point_entries = PointEntry.new(pointEntriesParams)
  if @point_entries.save
    redirect_to(root_path)
  else
    render(point_entries_path)
  end
end

private

def pointEntriesParams
  params.require(:member).permit(:UIN, :comment, :officerID, :pointChange)
end

end