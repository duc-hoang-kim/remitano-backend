require 'rails_helper'

describe "home page", type: :feature do
  let!(:video_1) { create(:video) }
  let!(:video_2) { create(:video) }
  let!(:video_3) { create(:video) }
  let!(:video_4) { create(:video) }
  let!(:video_5) { create(:video) }

  before { visit "/" }

  it "load video of page 1" do
    expect(page).not_to have_content(video_1.title)
    expect(page).to have_content(video_2.title)
    expect(page).to have_content(video_3.title)
    expect(page).to have_content(video_4.title)
    expect(page).to have_content(video_5.title)
  end

  it "show all infos of videos" do
    expect(page).to have_content(video_2.title)
    expect(page).to have_content(video_2.description)
    expect(page).to have_content(video_2.sharer.email)
    expect(page).to have_content(video_2.sharer.email)
    expect(page).to have_content(video_2.sharer.email)
  end

  context 'switch to page 2' do
    it 'show items on page 2' do
      click_button('2')

      expect(page).to have_content(video_1.title)
      expect(page).not_to have_content(video_2.title)
      expect(page).not_to have_content(video_3.title)
      expect(page).not_to have_content(video_4.title)
      expect(page).not_to have_content(video_5.title)
    end
  end
end
