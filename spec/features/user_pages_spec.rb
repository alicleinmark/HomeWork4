require 'rails_helper'
RSpec.describe "UserPages", :type => :request do
  describe "GET /user_pages" do
    it "Sign Up page exists" do
	get signup_path
	expect(response).to have_http_status(200)
	end
  end
end

describe "User pages" do
	let(:base_title) { "USMA CS450" }
 describe "Signup page" do
	before {visit signup_path}	
	let(:submit) { "Create my account" }
	
	describe "with invalid information" do
	  it "should not create a user" do
	    expect { click_button submit }.not_to change(User, :count)
	  end
	end

	describe "with valid information" do
	  before do
	    fill_in "Name",	 with: "Example User"
	    fill_in "Email",	 with: "user@example.com"
	    fill_in "Password",	 with: "foobar"
	    fill_in "Confirmation", with: "foobar"
	end

	it "should create a user" do
	  expect { click_button submit }.to change(User, :count).by(1)
	end

    it "should have the h1 'USMA CS450 Sample App'" do
       expect(page).to have_selector('h1', :text => 'Sign Up')
    end
	it "should have the title 'Sign Up'" do
		expect(page).to have_title "#{base_title} | Sign Up"
	end
  end
end
end
