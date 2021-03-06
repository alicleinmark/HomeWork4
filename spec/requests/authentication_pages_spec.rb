require 'rails_helper'

RSpec.describe "AuthenticationPages", :type => :request do
  describe "GET /authentication_pages" do
    it "works! (now write some real specs)" do
      get authentication_pages_index_path
      expect(response).to have_http_status(200)

  describe "signin page" do
   before { visit signin_path }

   describe "with invalid information" do
    before { click_button "Sign in" }
 
   it { should have_selector('title', text: 'Sign in') }
   it { should have_selector('div.alert.alert-error', text: 'Invalid') }

   describe "after visiting another page" do
     before { click_link "Home" }
     it { should_not have_selector('div.alert.alert-error') }
    end
   end

   describe "with valid information" do 
    let(:user) { FactoryGirl.create(:user) }
    before do
     fill_in "Email", with: user.email
     fill_in "Password", with: user.password
     click_button "Sign in"
   end
   it { should have_selector('title', text:user.name) }
   it { should have_link('Profile', href:user_path(user)) }
   it { hsould have_link('Sign out', href:signout_path) }
   it { should_not have_link('Sign in', href:signin_path) }
    end
  end
end
