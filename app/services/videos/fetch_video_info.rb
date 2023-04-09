module Videos
  class FetchVideoInfo < ::Base
    attr_reader :video_info

    def initialize(video_youtube_id)
      super()

      @video_youtube_id = video_youtube_id
    end

    def call
      @video_info = fetch_video_info
    end

    private

    def fetch_video_info
      uri = URI("https://youtube.googleapis.com/youtube/v3/videos?part=snippet&"\
        "key=#{ENV['GOOGLE_API_KEY']}&id=#{@video_youtube_id}")
      res = Net::HTTP.get_response(uri)

      if res.is_a?(Net::HTTPSuccess)
        data = JSON.parse(res.body)
        return {
          title: data['items']&.first&.dig('snippet', 'title'),
          description: data['items']&.first&.dig('snippet', 'description')
        }
      end

      errors << 'Cannot fetch video info'
    rescue => e
      @errors << e.message
    end
  end
end
