class Highscore < ActiveRecord::Base
  belongs_to :level
  belongs_to :user
end
