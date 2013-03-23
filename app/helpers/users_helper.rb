module UsersHelper

	# Returns the Gravatar for the given user.
	def gravatar_for(user)
	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	gravatr_url = "http://www.gravatar.com/avatar/#{gravatar_id}"
	image_tag(gravatr_url, alt: user.name, class: "gravatar")
	end

end
