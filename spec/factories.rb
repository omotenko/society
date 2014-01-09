FactoryGirl.define do 
	factory :user do
		name                  "Oleg"
		email                 "o.motenko@mail.ru"
		password              "motenko"
		password_confirmation "motenko"
	end
end