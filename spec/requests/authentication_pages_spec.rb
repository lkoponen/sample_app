require 'spec_helper'

describe "AuthenticationPages" do

	subject { page }
	
	describe "signin page" do
		before { visit signin_path }

		it { should have_h1_signin }
		it { should have_title_signin }
	end

	describe "signin" do
		before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign In" }

			it { should have_title_signin }
			it { should have_error_message }

			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_error_message }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
				
			before { valid_signin(user) }

			it { should have_title_username }
			it { should have_link('Users', href: users_path) }
			it { should have_link_profile }
			it { should have_link_settings }
			it { should have_link_signout }
			it { should_not have_signin_link }

			describe "followed by signout" do
				before { click_link "Sign Out" }
				it { should have_signin_link }
			end
		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email", with: user.email
					fill_in "Password", with: user.password
					click_button "Sign In"
				end

				describe "after siging in" do

					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edit user')
					end
				end
			end
			
			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_selector('title', text: 'Sign In') }
				end

				describe "submitting to the update action" do
					before { put user_path(user) }
					specify { response.should redirect_to(signin_path) }
				end

				describe "visiting the user index" do
					before { visit users_path }
					it { should have_selector('title', text: 'Sign In') }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { valid_signin(user) }

			describe "visiting Users#edit page" do
				before { visit edit_user_path(wrong_user) }
				it { should_not have_selector('title', text: full_title('Edit user')) }
			end

			describe "submitting a PUT request to the Users#update action" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(root_path) }
			end
		end

		describe "as a non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }

			before { valid_signin(non_admin) }

			describe "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(user) }
				specify { response.should redirect_to(root_path) }
			end
		end
	end
end
