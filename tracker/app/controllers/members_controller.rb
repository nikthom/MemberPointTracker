class MembersController < ApplicationController
  helper_method :sort_column_members, :sort_direction_members, :sort_direction_officers, :sort_column_officers
  layout 'navbar'

  def index
    #@members = Member.order(:points => "desc")
    @members = Member.order(sort_column_members + " " + sort_direction_members) #query db in asc/desc order
    @officers = Officer.order(sort_column_officers + " " + sort_direction_officers)
    #flash[:notice] = "There are #{@members.size} members available."

    @membersUnsorted = Member.all
    respond_to do |format|
      format.html
      format.csv {send_data @membersUnsorted.to_csv, filename: "members-#{Date.today}.csv" }
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new({:points => 0})
  end

  def create
     #instantiate a new object using form paramaters
     @member = Member.new(member_params)

     #save the object
     if @member.save
       #if save succeeds, redirect to the index action
       flash[:notice] = "A member <#{@member.name}> was created successfully"
       redirect_to(members_path)
     else
       #if save fails, redisplay the form but the fields will already be pre-filled
       render('new')
     end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    #find ax existing object using form paramaters
    @member = Member.find(params[:id])

    #update the object
    if @member.update_attributes(member_params)
      #if save succeeds, redirect to the show action
      flash[:notice] = "A member <#{@member.name}> was updated successfully"
      redirect_to(members_path)
    else
      #if save fails, redisplay the form but the fields will already be pre-filled
      render('edit')
    end
  end

  def newPointEntry

    @point_entry = PointEntry.new({:points_add => 0,:points_remove => 0 })

  end

  def processNewPointEntry
    @point_entry = PointEntry.new(points_entry_params)
    if @point_entry.uin.present? && @point_entry.uin.present? && @point_entry.points_add.present? && @point_entry.points_add.present?
        @point_entry.save
        if  @member =  Member.find_by_uin(@point_entry.uin)
            @member.points += @point_entry.points_add
            @member.points -=  @point_entry.points_remove
            if @member.save
              redirect_to(members_path)
            else
              flash.now[:notice] = "Failed to save."
              render('newPointEntry')
            end
        else
          flash.now[:notice] = "Can't find member with the UIN entered."
          render('newPointEntry')
        end

    else
          flash.now[:notice] = "Please fill in all the info. "
          render('newPointEntry')
    end
  end

  def delete
    @member = Member.find(params[:id])
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    flash[:notice] = "A member <#{@member.name}> was deleted successfully"
    redirect_to(members_path)
  end

  private

  def points_entry_params
    params.require(:point_entry).permit(:uin, :officerId, :points_add, :points_remove, :comment)
  end

  def member_params
    params.require(:member).permit(:name, :email, :uin, :points )
  end

  def sort_column_members
    Member.column_names.include?(params[:sort]) ? params[:sort]: "points"
  end

  def sort_direction_members
    %w[ASC DESC].include?(params[:direction]) ? params[:direction] : "DESC"
  end

  def sort_column_officers
    Officer.column_names.include?(params[:sort]) ? params[:sort]: "points"
  end

  def sort_direction_officers
    %w[ASC DESC].include?(params[:direction]) ? params[:direction] : "DESC"
  end

end
