ActiveAdmin.register Level do
	index do
		column :id
		column :user
		column :order_index

		column :title do |post|
			link_to post.title, game_path(post)
		end
		column :playable
		column :user_id

		column :times_played
		column :times_completed

		column :created_at
		column :updated_at

		default_actions

	end

	#filter :playable, :as => :check_boxes
end


