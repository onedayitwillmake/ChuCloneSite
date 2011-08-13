class User < ActiveRecord::Base
  has_many :highscores
  has_many :levels
  
  # Modify the user before it is saved to the DB to set the auth properties
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['user_info']["nickname"]
    end
  end
end
