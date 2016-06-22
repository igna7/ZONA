class Article < ActiveRecord::Base
	include PermissionsConcern
	acts_as_votable
	belongs_to :user
	before_save :set_visits_count

	has_attached_file :cover, styles: {thumb: "400x300", medium: "800x600" }
  	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  	validates :title, presence: true, uniqueness: true, length: {maximum: 42}
  	validates :body, presence: true, length: {minimum: 100}

  	def update_visits_count
  		self.update(visits_count: self.visits_count + 1)
  	end

  	private

  	def set_visits_count
  		self.visits_count ||= 0
  	end

end
