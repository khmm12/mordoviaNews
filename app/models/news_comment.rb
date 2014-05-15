class NewsComment < ActiveRecord::Base
    belongs_to :news
    belongs_to :user

    validates_presence_of :content, :ip, :news, :user
    validates_length_of :content, :minimum => 5
end
