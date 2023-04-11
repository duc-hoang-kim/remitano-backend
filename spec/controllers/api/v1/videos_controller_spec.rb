require 'rails_helper'

RSpec.describe Api::V1::VideosController, type: :controller do
  describe "POST /api/v1/videos" do
    let(:user) { create(:user) }
    let(:video) { create(:video, sharer: user) }
    let(:service_double) { double(call: nil, success?: true, video: ) }

    before do
      allow(Videos::CreateVideo).to receive(:new).and_return(service_double)
    end

    context 'authenticated user' do
      before do
        user.confirm
        sign_in(user)
      end

      it 'call api successfully' do
        post :create, params: { video: {youtube_url: 'https://remitano.com/'} }

        expect(response.code).to eq('201')

        expect(JSON.parse(response.body)['data']).to eql({
          "id" => video.id,
          "youtube_url"=> video.youtube_url,
          "sharer_email"=> video.sharer.email,
          "upvote_count"=> video.upvote_count,
          "downvote_count"=> video.downvote_count,
          "description"=> video.description,
          "title"=> video.title,
          "created_at"=> video.created_at.iso8601(3),
          "youtube_id"=> video.youtube_id
        })
      end
    end

    context 'anonymous user' do
      it 'return unauthorize code' do
        post :create, params: { video: {youtube_url: 'https://remitano.com/'} }

        expect(response.code).to eq('401')
      end
    end
  end

  describe "GET /api/v1/videos" do
    let(:user) { create(:user) }
    let(:service_double) { double(call: nil, success?: true, video: create(:video)) }
    let!(:page_2_videos) {[
      create(:video, created_at: 5.day.ago),
      create(:video, created_at: 6.day.ago),
      create(:video, created_at: 7.day.ago),
      create(:video, created_at: 8.day.ago),
    ]}
    let!(:page_1_videos) {[
      create(:video, created_at: 4.day.ago),
      create(:video, created_at: 3.day.ago),
      create(:video, created_at: 2.day.ago),
      create(:video, created_at: 1.day.ago),
    ]}


    it 'call api successfully' do
      get :index

      expected_response_data = page_1_videos.map do |v|
        {
          "id" => v.id,
          "youtube_url"=> v.youtube_url,
          "sharer_email"=> v.sharer.email,
          "upvote_count"=> v.upvote_count,
          "downvote_count"=> v.downvote_count,
          "description"=> v.description,
          "title"=> v.title,
          "created_at"=> v.created_at.iso8601(3),
          "youtube_id"=> v.youtube_id
        }
      end

      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['data']).to match_array(expected_response_data)
    end

    it 'get page 2' do
      get :index, params: { page: 2 }

      expected_response_data = page_2_videos.map do |v|
        {
          "id" => v.id,
          "youtube_url"=> v.youtube_url,
          "sharer_email"=> v.sharer.email,
          "upvote_count"=> v.upvote_count,
          "downvote_count"=> v.downvote_count,
          "description"=> v.description,
          "title"=> v.title,
          "created_at"=> v.created_at.iso8601(3),
          "youtube_id"=> v.youtube_id
        }
      end

      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['data']).to match_array(expected_response_data)
    end

    it 'with custom per page' do
      get :index, params: { per_page: 8 }

      expected_response_data = (page_1_videos + page_2_videos).map do |v|
        {
          "id" => v.id,
          "youtube_url"=> v.youtube_url,
          "sharer_email"=> v.sharer.email,
          "upvote_count"=> v.upvote_count,
          "downvote_count"=> v.downvote_count,
          "description"=> v.description,
          "title"=> v.title,
          "created_at"=> v.created_at.iso8601(3),
          "youtube_id"=> v.youtube_id
        }
      end

      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['data']).to match_array(expected_response_data)
    end
  end
end
