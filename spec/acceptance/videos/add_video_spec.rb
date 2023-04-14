require "rails_helper"

describe "add a video flow", type: :feature do
  let(:user) { create(:user, password: "123456", password_confirmation: "123456") }

  context "logged in user" do
    before do
      sign_in_use(user.email, "123456")

      click_button("Share a Movie")

      fill_in "Youtube URL", with: youtube_url
    end

    context "valid url" do
      let(:youtube_url) { "https://www.youtube.com/watch?v=yzInC0lHIMM" }

      it "add video to page" do
        VCR.use_cassette("fetch info valid url") do
          click_button("Share")
        end
        expect(page).to have_content("Post Malone - One Night in Rome, Italy (Full Concert)")
      end
    end

    context "invalid url" do
      let(:youtube_url) { "https://facebook.com" }

      it "show error" do
        VCR.use_cassette("fetch info invalid url") do
          click_button("Share")
        end
        expect(page).to have_content("Invalid youtube url")
      end
    end
  end

  context "anonymous user" do
    it "didn't show share button" do
      expect(page).not_to have_content("Share a Movie")
    end
  end
end
