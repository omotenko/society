require 'spec_helper'

describe "AuthenticationPages" do
	subject {page}
    
    describe "signin page" do
    	
    	describe "with valid information" do
    		let(:user) {FactoryGirl.create(:user)}
    		before{sign_in user}
    		it {should have_title(full_title(user.name))}
    		it {should have_link("Sign out",signout_path)}
    		it {should have_link("Profile",user_path(user))}
            it {should have_link("Settings",edit_user_path(user))}
    		it {should_not have_link("Sign in",signin_path)}
    	end
    end
    describe "authorization" do
        
        describe "for non-signed-in Users" do 
            let(:user) {FactoryGirl.create(:user)}
            
            describe "visiting edit page" do
                before{ visit edit_user_path(user) }
                it {should have_title(full_title("Sign in"))}
            end

            describe "submiting to the update action" do
                before{ put user_path(user) }
                specify{ response.should redirect_to(signin_path) }
            end
        end

        describe "as wrong user" do
            let(:user) {FactoryGirl.create(:user)}
            let(:wrong_user) {FactoryGirl.create(:user, email:"new_email@mail.ru")}
            before {sign_in user}

            describe "visiting Users#edit page" do
                before { visit edit_user_path(wrong_user) }

                it { should_not have_title(full_title("Update profile")) }
            end

            describe "submitting a PUT request to the User#update action" do
                before { put user_path(wrong_user) }

                specify{ response.should redirect_to(root_path) }
            end
        end

        describe "when attempting to visit a protected page" do
            let(:user) {FactoryGirl.create(:user)}
            before do
                visit edit_user_path(user)
                fill_in "Email"    , with:user.name
                fill_in "Password" , with:user.password
                click_button "Sign in"
            end

            it {should  have_selector("h1","Update your profile")}
        end
    end

end
