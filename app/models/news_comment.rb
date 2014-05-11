class NewsComment < ActiveRecord::Base
    belongs_to :news

    validates_presence_of :email, :name, :content, :ip
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_length_of :name, :in => 3..15
    validates_length_of :content, :minimum => 5
end
