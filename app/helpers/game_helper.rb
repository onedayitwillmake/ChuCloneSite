module GameHelper
	def has_highscore highscores, level_id
		return false if highscores == nil
		highscores.each do |score|
			return true if score.level_id == level_id
		end

		false
	end
end