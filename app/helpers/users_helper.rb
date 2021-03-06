module UsersHelper

	# Returns the Gravatar for the given user.
	def gravatar_for(user, options = { size: 50 })
	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	size = options[:size]
	gravatr_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	image_tag(gravatr_url, alt: user.name, class: "gravatar")
	end

end
