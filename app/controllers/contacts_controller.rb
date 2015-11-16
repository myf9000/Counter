
  class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(params[:contact])
		@contact.request = request
		if verify_recaptcha(:contact => @contact) && @contact.deliver
			flash[:success]= "Thanks for your message! I'll get back to you soon!"
			redirect_to root_path
		else 
			flash.now[:error]= "Cannot send message"
			render :new
		end
	end
end

