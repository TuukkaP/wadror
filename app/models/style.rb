class Style < ActiveRecord::Base
  include AverageRating

  has_many :beers
  has_many :ratings, through: :beers

  def favorite_style
    taulu = Array.new()
    Style.all.each { |s| taulu += [s.name => s.average_rating.to_f] unless s.average_rating.nil?}
    taulu.max_by { |k, v| v }
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.beers.inject(0) { |sum,  b| sum + b.average_rating.to_f } || 0) }
    sorted_by_rating_in_desc_order.take(n)
  end

  def to_s
    "#{name}"
  end
end
