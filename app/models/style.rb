class Style < ActiveRecord::Base
  include AverageRating

  has_many :beers
  has_many :ratings, through: :beers

  def favorite_style
    taulu = Array.new()
    Style.all.each { |s| taulu += [s.name => s.average_rating.to_f] unless s.average_rating.nil?}
    taulu.max_by { |k, v| v }
  end

  def to_s
    "#{name}"
  end
end
