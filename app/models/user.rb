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
    user
  end

  def follow!(amigo_id)
    friendships.create(friend_id: amigo_id)
  end

  def can_follow?(amigo_id)
    not amigo_id == self.id or friendships.where(friend_id: amigo_id).size > 0
  end

  has_many :articles
  has_many :friendships
  has_many :follows, through: :friendships, source: :user

  has_many :followers_friendships, class_name: "Friendship", foreign_key: "user_id"
  has_many :followers, through: :followers_friendships, source: :friend

  include PermissionsConcern
end
