class MembersController < ApplicationController

  def index
    @members = Member.order(:points => "desc")
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
       flash[:notice] = "#{@member.name} was created successfully"
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
      flash[:notice] = "#{@member.name} was updated successfully"
      redirect_to(members_path)
    else
      #if save fails, redisplay the form but the fields will already be pre-filled
      render('edit') 
    end
  end

  def delete
    @member = Member.find(params[:id])
  end
  
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    flash[:notice] = "#{@member.name} was deleted successfully"
    redirect_to(members_path)
  end

  private

  def member_params
    params.require(:member).permit(:name, :email, :UIN, :points )
  end

end