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
			it { should have_link_profile }
			it { should have_link_signout }
			it { should_not have_signin_link }

			describe "followed by signout" do
				before { click_link "Sign Out" }
				it { should have_signin_link }
			end
		end
	end
end
