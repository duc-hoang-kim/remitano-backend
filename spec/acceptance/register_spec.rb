require "rails_helper"

describe "the sign up process", type: :feature do
  before do
    visit "/"

    click_button("Login / Register")
    click_button("Register")
  end

  context "correct email and password" do
    it "signs me in" do
      within "form#register-form" do
        fill_in "email-input", with: "new_user@mail.com"
        fill_in "Password", with: "123456"
        fill_in "Password confirmation", with: "123456"
      end

      click_button("Register")

      expect(page).to have_content("Your account was created successfully, you can login to your account now")
      # able to login
      sign_in_use("new_user@mail.com", "123456")
      expect(page).to have_content("Welcome new_user@mail.com")
    end
  end

  context "email was taken" do
    let!(:user) { create(:user, password: "123456", password_confirmation: "123456") }

    it "show error" do
      within "form#register-form" do
        fill_in "email-input", with: user.email
        fill_in "Password", with: "123456"
        fill_in "Password confirmation", with: "123456"
      end

      click_button("Register")

      expect(page).to have_content("Email has already been taken")
    end
  end
end
