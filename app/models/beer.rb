class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    #@sum = 0
    #  ratings.each do |r|
    #    @sum += r.score
    #end
    #return @sum/ratings.count


    return ratings.average('score')
    end
end
