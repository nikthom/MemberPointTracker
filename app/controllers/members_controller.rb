require 'http'
require 'cgi'
require 'json'
class MembersController < ApplicationController
  helper_method :sort_column_members, :sort_direction_members, :sort_direction_officers, :sort_column_officers
  layout 'navbar', :except => [:login, :show_member, :attemptLogin]

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

  def log
    @member = Member.find(params[:id])
    @uin = @member.uin
    @customPoints = PointEntry.where(:uin => @uin)

    @totalCustomPoints = 0
    @customPoints.each do |n|
      @totalCustomPoints += (n.points_add + n.points_remove)
    end

    @outArr = []
    #@entries = AttendanceEntry.where(:uin => @uin)
    @entries = Attendance.where(:uin => @uin)


    @totalAttendancePoints = 0
    @entries.each do |entry| 
      #currEvent = entry.event
      currEvent = Event.find_by_ptId(entry.eventId)
      if currEvent
        @outArr.append(currEvent)
        @totalAttendancePoints += currEvent.pointsWorth
      end
    end

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
    @point_entry.officerId = session[:userId]
    @point_entry.name = Member.find_by_uin(@point_entry.uin).name
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
    @member.specialDelete
    flash[:notice] = "A member <#{@member.name}> was deleted successfully"
    redirect_to(members_path)
  end

  def login
    #form

  end

  def logout
    session[:memberId] = nil
    redirect_to(members_login_path)
  end  

  def attemptLogin
    if params[:uin].present?
      currUser = Member.find_by_uin(params[:uin])
      if currUser 
        session[:memberId] = currUser.id
        flash[:notice] = "User <#{currUser.name}> has successfully logged in!"
        redirect_to(members_show_member_path)
      else
        flash.now[:notice] = "Invalid UIN"
        render('login')
      end
    else
      flash.now[:notice] = "Please fill in your UIN"
      render('login')
    end

    

  end

  def show_member
    @member_id = session[:memberId]
    @member = Member.find(@member_id)
    @uin = @member.uin
    @customPoints = PointEntry.where(:uin => @uin)

    @totalCustomPoints = 0
    @customPoints.each do |n|
      @totalCustomPoints += (n.points_add + n.points_remove)
    end

    @outArr = []
    #@entries = AttendanceEntry.where(:uin => @uin)
    @entries = Attendance.where(:uin => @uin)


    @totalAttendancePoints = 0
    @entries.each do |entry| 
      #currEvent = entry.event
      currEvent = Event.find_by_ptId(entry.eventId)
      if currEvent
        @outArr.append(currEvent)
        @totalAttendancePoints += currEvent.pointsWorth
      end
    end
  end

  def loadAttendanceData
    #do users table
    @response = HTTP.get 'https://asabe-participation-tracker.herokuapp.com/api/v1/users?token=b0f368ceed01c59e41714b6bbd04e8e3'
    @response = @response.body
    @response = JSON.parse(@response)
    hash = {}
    
    for i in 0..@response.length - 1
      hash[@response[i]['id']] = @response[i]['uin']
      if !@response[i]['is_admin'] && !Member.exists?(uin: @response[i]['uin'])
        Member.create(:name => @response[i]['name'], :email => @response[i]['email'], :uin => @response[i]['uin'], :points => 0)
      end

    end
    #do response for events
    @events = HTTP.get 'https://asabe-participation-tracker.herokuapp.com/api/v1/events?token=b0f368ceed01c59e41714b6bbd04e8e3'
    @events = @events.body
    @events = JSON.parse(@events)
    Event.all.each do |event|
      event.destroy
    end
    for i in 0..@events.length - 1
        Event.create(:name => @events[i]['title'], :description => @events[i]['description'], :pointsWorth => 5, :ptId => @events[i]['id'])
    end
    #do response for attendance entries
    @entries = HTTP.get 'https://asabe-participation-tracker.herokuapp.com/api/v1/attendances?token=b0f368ceed01c59e41714b6bbd04e8e3'
    @entries = @entries.body
    @entries = JSON.parse(@entries)
    for i in 0..@entries.length - 1
      if !Attendance.exists?(uin: hash[@entries[i]['user'].to_i], eventId: @entries[i]['event']) and Event.exists?(ptId: @entries[i]['event'])
        attendance = Attendance.create(:uin => hash[@entries[i]['user'].to_i], :eventId => @entries[i]['event'])
        @mem = Member.find_by_uin(hash[@entries[i]['user'].to_i])
        if @mem
          @mem.points += 5
          @mem.save
        else
          @off = Officer.find_by_uin(hash[@entries[i]['user'].to_i])
          if @off
            @off.points += 5
            @off.save
          else
            differentFlash = TRUE
            attendance.destroy
          end
        end
      end
    end
    @response = hash
    if differentFlash
      flash[:notice] = "Data from participation tracker loaded. Note that participation data exists for an officer account that has not yet been created."
    else
      flash[:notice] = "Data from participation tracker loaded"
    end
    #Member.resetHash(hash)
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
