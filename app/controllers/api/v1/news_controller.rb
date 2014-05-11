module Api
    module V1
        class NewsController < ApplicationController
            def index
                @news = params[:news_category_id] ? News.where(news_category_id: params[:news_category_id]).all : News.all
                if params[:length]
                    render json: @news.length.as_json
                    return true
                end
                @news = @news.order 'created_at DESC'
                @news = @news.page(params[:page]).per(params[:page_size]) if params[:page]
            end

            def show
                @new = News.find params[:id]
            end
        end
    end
end
