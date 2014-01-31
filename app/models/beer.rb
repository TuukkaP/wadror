class Beer < ActiveRecord::Base
  include AverageRating

  validates :name, uniqueness: true, presence: true, length: { minimum: 3 }

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    "#{brewery.name}, #{name}"
  end
end
