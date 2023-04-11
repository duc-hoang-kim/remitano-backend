require "rails_helper"

describe ::Videos::FetchVideoInfo do
  let(:video_youtube_id) { "09839DpTctU" }

  subject {
    described_class.new(video_youtube_id)
  }

  context 'fetch successfully' do
    it 'success and parse title, description' do
      VCR.use_cassette("fetch_video_info") do
        subject.call
      end

      expect(subject.success?).to be_truthy
      expect(subject.video_info).to eq({
        :title => "Eagles - Hotel California (Live 1977) (Official Video) [HD]",
        :description => "HD Remastered Official Music Video for \"Hotel California\" "\
                        "(Live from the Capital Centre in Landover, Maryland in 1977) "\
                        "performed by the Eagles. Original song from 'Hotel California' "\
                        "(1976). \n\n♪ The Latest from Eagles https://linktr.ee/eaglesband\n\n🕭 "\
                        "Subscribe to the Eagles' channel https://Rhino.lnk.to/EaglesYTID\n\n♪ "\
                        "Eagles Tour https://eagles.com/events \n♪ Eagles Store https://eagles.com/store "\
                        "\n♪ Website https://eagles.com/ \n♪ Facebook https://www.facebook.com/EaglesBand "\
                        "\n♪ Instagram https://www.instagram.com/eagles/"})
    end
  end

  context 'fetch with not exist id' do
    let(:video_youtube_id) { "not-exist-id" }

    it 'success but not able to parse title, description' do
      VCR.use_cassette("fetch_video_info_fail") do
        subject.call
      end

      expect(subject.success?).to be_truthy
      expect(subject.video_info).to eq({
        title: nil,
        description: nil
      })
    end
  end

  context 'lose internet connection' do
    before do
      allow(Net::HTTP).to receive(:get_response).and_raise("Failed to open TCP connection to youtube.googleapis.com:443 "\
                                                           "(getaddrinfo: nodename nor servname provided, or not known)")
    end

    it 'fail with corresponding error' do
      subject.call

      expect(subject.success?).to be_falsy
      expect(subject.errors).to eq(["Failed to open TCP connection to youtube.googleapis.com:443 "\
                                    "(getaddrinfo: nodename nor servname provided, or not known)"])
    end
  end
end
