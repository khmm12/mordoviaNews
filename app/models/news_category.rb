class NewsCategory < ActiveRecord::Base
    has_many :news
    def title_latin
        Cyrillizer.language = :russian
        title.to_lat
    end
end
