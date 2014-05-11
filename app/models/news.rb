class News < ActiveRecord::Base
    belongs_to :news_category
    has_many :news_comments
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
