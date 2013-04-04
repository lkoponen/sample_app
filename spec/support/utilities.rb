include ApplicationHelper

def valid_signin(user)
	visit signin_path
	fill_in "Email",    with: user.email
	fill_in "Password", with: user.password
	click_button "Sign In"
	# Sign in when not using Capybara as well.
	cookies[:remember_token] = user.remember_token
end

def valid_signup()
	fill_in "Name",         with: "Example User"
	fill_in "Email",        with: "user@example.com"
	fill_in "Password",     with: "foobar"
	fill_in "Confirmation", with: "foobar"
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: 'Invalid')
	end	
end


RSpec::Matchers.define :have_title_signin do |message|
	match do |page|
		page.should have_selector('title', text: 'Sign In')
	end
end

RSpec::Matchers.define :have_h1_signin do |message| 
	match do |page|
		page.should have_selector('h1', text: 'Sign In')
	end
end

RSpec::Matchers.define :have_title_username do |message|
	match do |page|
		page.should have_selector('title', text: user.name)
	end
end

RSpec::Matchers.define :have_link_profile do |message|
	match do |page|
		page.should have_link('Profile', href: user_path(user))
	end
end

RSpec::Matchers.define :have_link_signout do |message|
	match do |page|
		page.should have_link('Sign Out', href: signout_path)
	end
end

RSpec::Matchers.define :have_signin_link do |message|
	match do |page|
		page.should have_link('Sign In', href: signin_path)
	end
end

RSpec::Matchers.define :have_h1_signup do |message|
	match do |page|
		page.should have_selector('h1', text: 'Sign Up')
	end
end

RSpec::Matchers.define :have_title_signup do |message|
	match do |page|
		page.should have_selector('title', text:full_title('Sign Up'))
	end
end

RSpec::Matchers.define :have_h1_username do |message|
	match do |page|
		page.should have_selector('h1', text: user.name)
	end
end

RSpec::Matchers.define :have_content_error do |message|
	match do |page|
		page.should have_content('error')
	end
end

RSpec::Matchers.define :have_content_password_digest do |message|
	match do |page|
		page.should_not have_content('Password digest')
	end
end

RSpec::Matchers.define :have_welcome_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-success', text: 'Welcome')
	end
end

RSpec::Matchers.define :have_link_settings do |message|
	match do |page|
		page.should have_link('Settings', href: edit_user_path(user))
	end
end