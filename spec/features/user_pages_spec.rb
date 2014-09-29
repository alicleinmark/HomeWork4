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

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end 

    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
  end 

	describe "edit" do
	 let(:user) {FactoryGirl.create(:user) }
	 before do
      sign_in user
      visit edit_user_path(user)
    end 

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end 
	
	describe "with invalid information" do
	  it "should not create a user" do
	    expect { click_button submit }.not_to change(User, :count)
	
      before { click_button "Save changes" }

      it { should have_content('error') }

	  end
	end
end

	describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
	  before do
	    fill_in "Name",	 with: "Example User"
	    fill_in "Email",	 with: "user@example.com"
	    fill_in "Password",	 with: "foobar"
	    fill_in "Confirmation", with: "foobar"
        click_button "Save changes"
	end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }

	it "should create a user" do
	  expect { click_button submit }.to change(User, :count).by(1)
	end

	describe "after saving the user" do

	 it {should have_link('Sign out') }
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
