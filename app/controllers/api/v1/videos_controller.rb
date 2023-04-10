module Api
  module V1
    class VideosController < ApplicationController
      before_action :set_video, only: %i[ show update destroy ]
      skip_before_action :authenticate_user!, only: :index

      def index
        @videos = paginate Video.all.order(created_at: :desc), per_page: 4

        render json: { data: ActiveModel::Serializer::CollectionSerializer.new(@videos) }
      end

      # POST /videos
      def create
        service = Videos::CreateVideo.new(current_user, video_params[:youtube_url])
        service.call

        if service.success?
          render json: { data: service.video }, status: :created
        else
          render json: { error: service.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /videos/1
      def destroy
        @video.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_video
        @video = Video.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def video_params
        params.require(:video).permit(:youtube_url)
      end
    end
  end
end
