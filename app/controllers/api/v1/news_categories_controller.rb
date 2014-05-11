module Api
    module V1
        class NewsCategoriesController < ApplicationController
            def index
                @news_categories = NewsCategory.all
            end

            def show
                @new_category = NewsCategory.find params[:id]
            end
        end
    end
end