class SessionsController < ApplicationController

def create
	user = User.find_by_email(params[:session][:email])
	if user && user.authenticate(params[:session][:password])
		sign_in user
		flash[:success] = user.name + " signed in successfully ;)"
		redirect_to user
	else
		flash.now[:error] = "Failed to log in, Invalid Email or password"
		render 'new'
	end
end

def destroy
	sign_out
	redirect_to root_path
end

end
