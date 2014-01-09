require 'spec_helper'

describe "UserPages" do
	subject {page}
	describe "sign up" do
		before {visit signup_path}
		let(:submit) {"Create new account"}

            describe "enable sign up page" do
				it {should have_selector('h1','Sign up')}
				it {should have_title(full_title('Sign Up'))}
            end

			describe "profile page" do
				let(:user) {FactoryGirl.create(:user)}
				before {visit user_path(user)}

				it {should have_selector('h1', user.name)}
				it {should have_title(full_title(user.name))}
			end

			describe "with invalid information" do
				it "should not create user" do
					expect {click_button submit}.not_to change(User,:count)
			    end
			end

			describe "with valid information" do
				before do
					fill_in "Name",                  with: "Oleg"
					fill_in "Email",                 with: "o.motenko@mail.ru"
					fill_in "Password",              with: "motenko"
					fill_in "Password confirmation", with: "motenko"
				end
				it "should create user" do
					expect {click_button submit}.to change(User,:count).by(1)
			    end
            end
    end

    describe "edit" do
    	let(:user) {FactoryGirl.create(:user)}
    	before do 
    		sign_in user
    		visit edit_user_path(user)
    	end
    	
    	describe "page" do 
	    	it {should have_selector("h1","Update your profile")}
	    	it {should have_title(full_title("Update profile"))}
        end

        describe "with invalid information" do
        	before {click_button "Save changes"}

        	it {should have_content("error")}
        end

        describe "with valid information" do
        	let(:new_name)  {"New name"}
        	let(:new_email) {"New email"}
        	before do
        		fill_in "Name"                  , with: new_name
        		fill_in "Email"                 , with: new_email
        		fill_in "Password"              , with: user.password
        		fill_in "Password confirmation" , with: user.password_confirmation
                click_button "Save changes"
           	end

           	it { should have_link('Sign out',signout_path) }
           	it { should_not have_link('Sign in',signin_path) }
           	#it {should have_selector('div.flash.flash_err')}
           	specify {user.reload.name == new_name}
           	specify {user.reload.email == new_email}
        end
    end
end