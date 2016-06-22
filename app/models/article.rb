class Article < ActiveRecord::Base
	belongs_to :user

	has_attached_file :cover, styles: {thumb: "400x300", medium: "800x600" }
  	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  	validates :title, presence: true, uniqueness: true, length: {maximum: 42}
  	validates :body, presence: true, length: {minimum: 100}
end
