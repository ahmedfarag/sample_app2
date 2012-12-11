require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "signup" do
    before{visit signup_path}

    let(:submit) { "Create my account" }

    describe "with invalid data" do
    	it "should not create a user" do
    	   expect{click_button submit}.not_to change(User, :count)
    	end
    end

    describe "with valid data" do
    	before do
	  		fill_in "Name", with: "Ahmed"
	      	fill_in "Email", with: "ahmed.farag1111@gmail.com"
	      	fill_in "Password", with: "foobar"
	      	fill_in "Confirmation", with: "foobar"
	    end
    	it "should create 1 user" do	
			expect {click_button submit}.to change(User, :count).by(1)
    	end
    	describe "should redirect to user profile" do	
			before{click_button submit}
			
			it { should have_selector('h1',    text: "Ahmed") }
    		it { should have_selector('title', text: "Ahmed") }
    	end
    end

  end
end