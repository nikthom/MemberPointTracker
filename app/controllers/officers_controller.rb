class OfficersController < ApplicationController
    def new
        @officer = Officer.new
    end

    def create
        @officer = Officer.new(officerParams)
        if @officer.save
            redirect_to(root_path)
        else
            render(new_officer_path)
        end
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

    def officerParams
        params.require(:officer).permit(:name, :email, :position, :uin, :password)
    end
end
