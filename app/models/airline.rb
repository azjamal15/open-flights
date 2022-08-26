class Airline < ApplicationRecord
  has_many :reviews

  before_create :slugify #sets slug for airline before we create to database 

  def slugify 
    self.slug = name.parametarize #takes airline name, creates a url safe version of the name and sets to slug value 
  end 

  def avg_score 
    reviews.average(:score).round(2).to_f #average of score, roudn to two places, convert to float
  end 
end
