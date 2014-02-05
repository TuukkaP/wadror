class User < ActiveRecord::Base
  include AverageRating
  has_secure_password

  validates :username, uniqueness: true, presence: true, length: { minimum: 3, maximum: 15 }
  validates :password, :format => { with:  /\A(?=.*[A-Z])(?=.*[0-9]).{4,}\z/, message: "must include one capital letter and one number and must be 4 characters long"}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :rated_beers, -> { uniq }, through: :ratings, source: :beer
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    hash = Hash.new()
    Style.all.each { |s| hash[s]= ratings.select{ |r| r.beer.style == s}.inject(0){ |sum, r| sum+r.score }}
    hash.max_by{ |k,v| v}[0]
  end

  def favorite_brewery
    return nil if ratings.empty?
    hash = Hash.new()
    Brewery.all.each { |b| hash[b]= ratings.select{ |r| r.beer.brewery == b}.inject(0){ |sum, r| sum+r.score }}
    hash.max_by{ |k,v| v}[0]
  end

end
