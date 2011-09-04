	ActiveAdmin.register Highscore do
		index do
			column :id
			column :user
			column :score
			column :level
			column :created_at
			column :updated_at

			default_actions
		end
	end
