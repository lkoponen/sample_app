require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_h1_signup }
  	it { should have_title_signup }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

  	it { should have_h1_username }
  	it { should have_title_username }
  end  	

  describe "signup" do
    
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title_signup }
        it { should have_content_error }
        it { should_not have_content_password_digest }
      end
    end

    describe "with valid information" do

      before { valid_signup() }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving a user" do
        
        before { click_button submit }
        let(:user) { User.find_by_email("user@example.com") }

        it { should have_title_username }
        it { should have_welcome_message }
        it { should have_link_signout }
      end
    end
  end
end
