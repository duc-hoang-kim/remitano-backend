require "rails_helper"

describe ::Videos::CreateVideo do
  let(:user) { create(:user) }
  let(:youtube_url) { "https://www.youtube.com/watch?v=yzInC0lHIMM" }
  let(:video_info) { { title: "title from Videos::FetchVideoInfo", description: "description from Videos::FetchVideoInfo" } }
  let(:fetch_video_info_service_double) { double(call: nil, success?: true, video_info: video_info) }

  subject {
    described_class.new(user, youtube_url)
  }

  before do
    allow(Videos::FetchVideoInfo).to receive(:new)
                                       .and_return(fetch_video_info_service_double)
  end

  shared_examples "parse correct youtube_id from the url" do |params = {}|
    let(:youtube_url) { params[:youtube_url] }

    before { subject.call }

    it "parse correct_id" do
      expect(subject.success?).to be_truthy
      expect(subject.video.youtube_id)
    end
  end

  context "call service Videos::FetchVideoInfo successfully" do
    # normal link
    include_examples "parse correct youtube_id from the url", {
      youtube_url: "https://www.youtube.com/watch?v=yzInC0lHIMM",
      expect_youtube_id: "yzInC0lHIMM",
    }

    # normal link with t params
    include_examples "parse correct youtube_id from the url", {
      youtube_url: "https://www.youtube.com/watch?v=_DfQC5qHhbo&t=200s",
      expect_youtube_id: "_DfQC5qHhbo",
    }

    # shared link
    include_examples "parse correct youtube_id from the url", {
      youtube_url: "https://youtu.be/yzInC0lHIMM",
      expect_youtube_id: "yzInC0lHIMM",
    }

    # shared link with t params
    include_examples "parse correct youtube_id from the url", {
      youtube_url: "https://youtu.be/_DfQC5qHhbo?t=16",
      expect_youtube_id: "_DfQC5qHhbo",
    }

    # short video link
    include_examples "parse correct youtube_id from the url", {
      youtube_url: "https://www.youtube.com/shorts/PxiavAM88G8",
      expect_youtube_id: "PxiavAM88G8",
    }

    # short video shared link
    include_examples "parse correct youtube_id from the url", {
      youtube_url: "https://youtube.com/shorts/CWYRjQ3e0Zg?feature=share",
      expect_youtube_id: "CWYRjQ3e0Zg",
    }

    it "create video with correct attributes" do
      subject.call

      expect(subject.success?).to be_truthy
      expect(subject.video.title).to eq(video_info[:title])
      expect(subject.video.description).to eq(video_info[:description])
      expect(subject.video.youtube_url).to eq(youtube_url)
    end
  end

  context "call service Videos::FetchVideoInfo fail" do
    let(:fetch_video_info_service_double) { double(call: nil, success?: false, video_info: nil, errors: ["something was wrong"]) }

    it "create video with correct attributes" do
      subject.call

      expect(subject.success?).to be_falsy
      expect(subject.errors).to eq(["something was wrong"])
    end
  end

  context "unsupported link" do
    let(:youtube_url) { "https://www.youtube.com/unsupported_link" }

    it "fail with Invalid youtube url error" do
      subject.call

      expect(subject.success?).to be_falsy
      expect(subject.errors).to eq(["Invalid youtube url"])
    end
  end

  context "youtube_url is not provided" do
    let(:youtube_url) { "" }

    it "fail with Missing youtube_url error" do
      subject.call

      expect(subject.success?).to be_falsy
      expect(subject.errors).to eq(["Missing youtube_url"])
    end
  end
end
