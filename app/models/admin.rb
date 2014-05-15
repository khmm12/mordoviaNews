class Admin < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable, :timeoutable,
         :authentication_keys => [:login_name]
end
