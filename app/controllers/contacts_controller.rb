class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # Send the email to the Admin.
      name  = params[:contact][:name]
      email = params[:contact][:email]
      body  = params[:contact][:comments]
      ContactMailer.contact_mail(name, email, body).deliver
      
      # Notifiy the end-user.
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end