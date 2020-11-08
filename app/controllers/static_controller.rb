class StaticController < ApplicationController
    
    layout 'navbar'
    def show
        render params[:page]
    end
end
