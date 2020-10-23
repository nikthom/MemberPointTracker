class OfficersController < ApplicationController
#  helper_method :sort_direction_officers, :sort_column_officers
#  layout 'navbar'
    def new
        @officer = Officer.new({:points => 0})
    end

    def create
        @officer = Officer.new(officerParams)
        if @officer.save
            redirect_to(root_path)
        else
            render(new_officer_path)
        end
    end

    def show
      @officer = Officer.find(params[:id])
    end

    def edit
      @officer = Officer.find(params[:id])
    end

    def update
      #find ax existing object using form paramaters
      @officer = Officer.find(params[:id])

      #update the object
      if @officer.update_attributes(officerParams)
        #if save succeeds, redirect to the show action
        flash[:notice] = "An officer <#{@officer.name}> was updated successfully"
        redirect_to(members_path)
      else
        #if save fails, redisplay the form but the fields will already be pre-filled
        render('edit')
      end
    end

    def delete
      @officer = Officer.find(params[:id])
    end

    def destroy
      @officer = Officer.find(params[:id])
      @officer.destroy
      flash[:notice] = "An officer <#{@officer.name}> was deleted successfully"
      redirect_to(members_path)
    end

    def login

    end

    def logout
        session[:userId] = nil
        redirect_to(root_path)
    end

    def attemptLogin
        if params[:email].present? && params[:password].present?
            currentUser = Officer.where(:email => params[:email]).first
            if currentUser && currentUser.authenticate(params[:password])
                session[:userId] = currentUser.id
                flash[:notice] = "User <#{params[:email]}> has successfully logged in!"
                redirect_to(members_path) #This should be changed to whatever the home page is later
            else
                flash.now[:notice] = "Invalid username or password."
                render('login')
            end
        else
            flash.now[:notice] = "Please fill in your info. "
            render('login')
        end
    end

    def newPointEntry

      @point_entry = PointEntry.new({:points_add => 0,:points_remove => 0 })

    end

    def processNewPointEntry
      @point_entry = PointEntry.new(points_entry_params)
      @point_entry.officerId = session[:userId]
      @point_entry.name = Officer.find_by_uin(@point_entry.uin).name
      if @point_entry.uin.present? && @point_entry.uin.present? && @point_entry.points_add.present? && @point_entry.points_add.present?
          @point_entry.save
          if  @officer =  Officer.find_by_uin(@point_entry.uin)
              @officer.points += @point_entry.points_add
              @officer.points -=  @point_entry.points_remove
              if @officer.save
                redirect_to(members_path)
              else
                flash.now[:notice] = "Failed to save."
                render('newPointEntry')
              end
          else
            flash.now[:notice] = "Can't find any officers with the UIN entered."
            render('newPointEntry')
          end

      else
            flash.now[:notice] = "Please fill in all the info. "
            render('newPointEntry')
      end
    end

    private

    def points_entry_params
      params.require(:point_entry).permit(:uin, :officerId, :points_add, :points_remove, :comment)
    end

    def officerParams
        params.require(:officer).permit(:name, :email, :points, :position, :uin, :password)
    end


end
