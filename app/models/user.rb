class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  
  def self.find_or_create_by_omniauth(auth)
  	user = User.where(provider: auth[:provider], uid: auth[:uid]).first
  	unless user
  		user = User.create(
  			name: auth[:name],
  			email: auth[:email],
  			provider: auth[:provider],
  			uid: auth[:uid],
  			password: Devise.friendly_token[0,20]
  			)
  	end
    return user
  end

  has_many :articles

  include PermissionsConcern
end
