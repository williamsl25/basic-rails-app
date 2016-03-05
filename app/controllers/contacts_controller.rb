class ContactsController < ApplicationController

  def show
    @contact = Contact.find params[:id]
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create que_params
    # redirect to our root page
    redirect_to root_path
  end

  def edit
    # make the variable
   @contact = Contact.find params[:id]
  end

   def update
    @contact = Contact.find params[:id]
    @contact.update_attributes que_params
    redirect_to root_path
  end

  def destroy
    @contact = Contact.find params[:id]
    @contact.delete
    redirect_to root_path
  end

private
  def que_params
    params.require(:contact).permit(:name)
  end
end

