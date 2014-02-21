class Rating < ActiveRecord::Base
  belongs_to :beer, touch: true
  belongs_to :user
  has_many :styles, through: :beer

  scope :recent, -> { last 5 }

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  def to_s
    "#{beer}: #{score}"
  end
end
