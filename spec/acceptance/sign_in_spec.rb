require "rails_helper"

describe "the sign in process", type: :feature do
  let!(:user) { create(:user, password: "123456", password_confirmation: "123456") }

  before do
    visit "/"

    click_button("Login / Register")
    expect(page).to have_content("Login to Funny Movies")
  end

  context "correct email and password" do
    it "signs me in" do
      within "form#login-form" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "123456"
      end

      click_button("Login")
      expect(page).to have_content("Welcome #{user.email}")
    end
  end

  context "wrong password" do
    it "show error" do
      within "form#login-form" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "abcdef"
      end

      click_button("Login")
      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
