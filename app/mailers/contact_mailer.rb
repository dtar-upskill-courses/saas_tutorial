class ContactMailer < ActionMailer:Base
  # NOTE: Changed to use the Admin email address from the secrets file.
  default to: Rails.application.secrets.admin_email_address
  
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    
    mail(body: email, subject: 'Contact Form Message')
  end
end