class ApplicationAssistance

	def check_auth_user(token)
		if User.find_by(:authentication_token => token)
			true
		end
	end

end
