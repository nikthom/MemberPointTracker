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

    def officerParams
        params.require(:officer).permit(:name, :email, :position, :UIN, :password)
    end
end
