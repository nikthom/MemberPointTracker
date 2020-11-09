class LeaderboardController < ApplicationController
    layout 'navbar'

    def view 
        @p = params[:reply]
        @c = params[:count]

        if @c == "All"
            @c = 100
        end
        @displayOut = []

        if @p == "Member"
            #@members = Member.limit(@c.to_i).order(:points => "desc")
            @members = Member.order(:points => "desc")
            prev = @members.first.points
            pos = 1
            buf = 0
            @displayFirst  = {"position" => "1", "name" => @members.first.name, "points" => prev}
            @displayOut.append(@displayFirst)
            @members.drop(1).each do |e|
                @displayMember = Hash.new
                if e.points < prev
                    pos = pos + 1 
                    buf = 0
                else
                    buf  = buf + 1
                end 
                prev = e.points
                @displayMember['position'] = pos
                @displayMember['name'] = e.name
                @displayMember['points'] = e.points
                if (pos <= @c.to_i)
                    @displayOut.append(@displayMember)
                end
            end

        elsif @p == "Officer"
            #@officers = Officer.limit(@c.to_i).order(:points => "desc")
            @officers = Officer.order(:points => "desc")
            prev = @officers.first.points
            pos = 1
            buf = 0
            @displayFirst  = {"position" => "1", "name" => @officers.first.name, "points" => prev}
            @displayOut.append(@displayFirst)
            @officers.drop(1).each do |e|
                @displayOfficer = Hash.new
                if(e.points < prev)
                    pos = pos + 1 
                    buf = 0
                else
                    buf = buf + 1
                end
                prev = e.points
                #@displayOfficer['buf'] = buf
                @displayOfficer['position'] = pos
                @displayOfficer['name'] = e.name
                @displayOfficer['points'] = e.points
                if (pos <= @c.to_i)
                    @displayOut.append(@displayOfficer)
                end
            end

        elsif @p != nil 
            #@officers = Officer.limit(@c.to_i).order(:points => "desc")
            @officers = Officer.order(:points => "desc")
            #@members = Member.limit(@c.to_i).order(:points => "desc")
            @members = Member.order(:points => "desc")
            @test = @officers + @members
            #@test = @test.take(@c.to_i)
            @test = @test.sort_by(&:points)
            @test = @test.reverse()
            prev = @test.first.points
            pos = 1
            buf = 0
            @displayFirst = {"position" => "1", "name" => @test.first.name, "points" => prev}
            @displayOut.append(@displayFirst)
            @test.drop(1).each do |e|
                @displayBoth = Hash.new
                if(e.points < prev)
                    pos = pos + 1 
                    buf = 0
                else
                    buf = buf + 1
                end
                prev = e.points
                #@displayBoth['buf'] = buf
                @displayBoth['position'] = pos
                @displayBoth['name'] = e.name
                @displayBoth['points'] = e.points
                if (pos <= @c.to_i)
                    @displayOut.append(@displayBoth)
                end
            end

        end

        respond_to do |format|
            format.html {render :view, locals: {status_msg: @c, feedback: params}}
        end

        
    end

end
