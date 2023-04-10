module Videos
  class CreateVideo < ::Base
    YOUTUBE_URL_PATTERN_1 = /youtube\.com\/watch\?v=/
    YOUTUBE_URL_PATTERN_2 = /youtu\.be\//

    attr_reader :video

    def initialize(youtube_url)
      super()

      youtube_url.strip!
      @youtube_url = youtube_url
    end

    def call
      @video = Video.new({
        youtube_url: @youtube_url,
        shared_by: 0
      })
      @video.youtube_id = extract_youtube_id
      return if error?

      video_info = get_video_info
      return if error?

      @video.title = video_info[:title]
      @video.description = video_info[:description]
      @video.save!
    rescue => e
      @errors << e.message
    end

    private

    # there are two forms of youtube video url
    # https://www.youtube.com/watch?v={video_id}
    # https://youtu.be/{video_id}
    def extract_youtube_id
      raise 'Missing youtube_url' unless @youtube_url

      youtube_id = nil

      if @youtube_url.match?(YOUTUBE_URL_PATTERN_1)
        youtube_id = CGI.parse(URI.parse(@youtube_url).query)["v"]&.first
      elsif @youtube_url.match?(YOUTUBE_URL_PATTERN_2)
        youtube_id = @youtube_url.match(/youtu.be\/([a-zA-Z]|\d|-)+/).to_s[9..]
      end
      raise 'Cannot parse video id from the url' unless youtube_id

      youtube_id
    end

    def get_video_info
      service = FetchVideoInfo.new(@video.youtube_id)
      service.call

      unless service.success?
        @errors += service.errors
      end

      service.video_info
    end
  end
end
