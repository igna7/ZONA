class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		auth = request.env["omniauth.auth"]
		raise auth.to_yaml
		
		data = {
			name: auth.info.name,
			email: auth.info.email,
			provider: auth.provider,
			uid: auth.uid
		}

		@user = User.find_or_create_by_omniauth(data)

		if @user.persisted?
			sign_in_and_redirect @user, event: :authentication
		else
			session[:omniauth_errors] = @user.errors.full_messages.to_sentence unless @user.save
			session[:omniauth_data] = data

			redirect_to new_user_registration_url
		end
	end

	def failure
    	redirect_to '/articles', notice: "An Error has occurred. Please try again!"
  	end
end