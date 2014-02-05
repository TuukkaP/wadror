class Brewery < ActiveRecord::Base
  include AverageRating

  validates :name, presence: true, length: { minimum: 3 }
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    only_integer: true }

  validate :brewery_cannot_be_established_in_the_future

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
    puts "number of ratings #{self.ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

  def brewery_cannot_be_established_in_the_future
    if year.present? && year > Date.today.year
      errors.add(:year, "cannot be established in the future!")
    end
  end

  def favorite_brewery
    taulu = Array.new()
    Brewery.all.each { |s| taulu += [s.name => s.average_rating.to_f] unless s.average_rating.nil?}
    taulu.max_by { |k, v| v }
  end

  def to_s
    "#{name}"
  end
end
