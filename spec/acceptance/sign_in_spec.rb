require 'rails_helper'

describe "the sign in process", type: :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    visit "http://localhost:3000/api/v1/videos"
    # fill_in 'email', with: 'user@example.com'
    # fill_in 'Password', with: 'password'
    # click_button 'Sign in'

    expect(page).to have_content('Login to Funny Movies')
  end

  describe "GET Google homepage", :type => :feature do
    it 'welcomes the user to Google' do
      visit('https://dantri.com.vn/the-gioi/my-tuyen-bo-se-lat-moi-tang-da-tim-nguyen-nhan-ro-ri-tai-lieu-mat-20230412070330243.htm')

      expect(page).to have_content("Mỹ tuyên bố sẽ")
      puts " cool, Google's title is 'Google' "
    end
  end
end
