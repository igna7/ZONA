class Article < ActiveRecord::Base
	include PermissionsConcern
	acts_as_votable
	belongs_to :user
  has_many :has_categories
  has_many :categories, through: :has_categories
  after_create :save_categories
	before_save :set_visits_count

	has_attached_file :cover, styles: {thumb: "400x300", medium: "800x600" }
  	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  	validates :title, presence: true, uniqueness: true, length: {maximum: 42}
  	validates :body, presence: true, length: {minimum: 100}

    #Custom SETTER
    def categories=(value)
      @categories = value
    end

  	def update_visits_count
  		self.update(visits_count: self.visits_count + 1)
  	end

  	private

  	def set_visits_count
  		self.visits_count ||= 0
  	end

    def save_categories
    @categories.each do |category_id|
      HasCategory.create(category_id: category_id, article_id: self.id)
    end
  end

end
