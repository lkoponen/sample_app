include ApplicationHelper

def valid_signin(user)
	fill_in "Email",    with: user.email
	fill_in "Password", with: user.password
	click_button "Sign In"
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: 'Invalid')
	end	
end


RSpec::Matchers.define :have_signin_title do |message|
	match do |page|
		page.should have_selector('title', text: 'Sign In')
	end
end

RSpec::Matchers.define :have_signin_h1 do |message| 
	match do |page|
		page.should have_selector('h1', text: 'Sign In')
	end
end

RSpec::Matchers.define :have_username_title do |message|
	match do |page|
		page.should have_selector('title', text: user.name)
	end
end

RSpec::Matchers.define :have_profile_link do |message|
	match do |page|
		page.should have_link('Profile', href: user_path(user))
	end
end

RSpec::Matchers.define :have_signout_link do |message|
	match do |page|
		page.should have_link('Sign Out', href: signout_path)
	end
end

RSpec::Matchers.define :have_signin_link do |message|
	match do |page|
		page.should have_link('Sign In', href: signin_path)
	end
end
