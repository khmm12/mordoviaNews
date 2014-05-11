module Api
    module V1
        class NewsCommentsController < ApplicationController
            respond_to :json
            def index
                @news_comments = NewsComment.where(news_id: params[:news_id]).order('created_at DESC').all
            end

            def show
                @news_comment = NewsComment.find params[:id]
            end

            def create
                @news_comment = NewsComment.new news_comment_params
                @news_comment.news_id = params[:news_id]
                @news_comment.ip = request.remote_ip
                @news_comment.save
                render json: @news_comment.errors, status: 400 if @news_comment.errors.any?
                @news_comment
            end

            def news_comment_params
                params.require(:news_comment).permit(:email, :name, :content)
            end
        end
    end
end