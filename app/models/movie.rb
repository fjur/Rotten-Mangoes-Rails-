class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: {only_integer: true}
  validates :description, presence: true
  # validates :poster_image_url, presence: true
  validates :release_date, presence: true

  validate :release_date_is_in_the_past

  mount_uploader :poster_image_url, ImageUploader

  scope :director_search, ->(director) {where("director LIKE ?", director)}
  scope :title_search, ->(title) {where("title LIKE ?", title)}
  scope :short, ->(duration) {where("runtime_in_minutes < ?", 90)}
  scope :medium, ->(duration) {where(runtime_in_minutes:  90..120)}
  scope :long, ->(duration) {where("runtime_in_minutes > ?", 120)}

  # scope :

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size unless reviews.count == 0
  end


  # HOW DO I IMPLEMENT OR SEARCHING
  def self.search(search)
    # binding.pry
    if search.count > 4
      if search[:name]
        @movie = Movie.title_search(search[:title])
        # @movies = Movie.where("title like ?", "%#{search[:name]}%")
      end
        # binding.pry
      if search[:director]
          @movies = Movie.director_search(search[:director])
        # @movies = @movies.where("director like ?", "%#{search[:director]}%")
      end
      if search[:duration]
        if search[:duration] == "Under 90 minutes"
          @movies = Movie.short(search[:duration])
          # @movies = @movies.where("runtime_in_minutes < 90")
        elsif "Between 90 and 120 minutes"
          @movies = Movie.medium(search[:duration])
          # @movies = @movies.where("runtime_in_minutes < 120 AND runtime_in_minutes > 90")
        else
          @movies = Movie.long(search[:duration])
          # @movies = @movies.where("runtime_in_minutes > 120")
        end
            
      end
    else
      @movies = Movie.all
    end
  end


end
