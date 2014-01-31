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

end
