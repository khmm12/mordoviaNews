class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :authentication_keys => [:username]
    has_many :news_comments

end
