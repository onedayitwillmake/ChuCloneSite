ActiveAdmin.register Level do
	index do
		column :id
		column :user
		column :order_index

		column :title do |post|
			link_to post.title, game_path(post)
		end


		column :Playable, :sortable => :playable do |level|
			link_to level.playable || 'false', "levels/#{level.id}/toggle"
		end
		##Link plaable to toggle action below
		#p = column :Playable do |level|
		#	link_to level.playable || 'false', "levels/#{level.id}/toggle"
		#end
		#column :playable, :sortable => true

		column :times_played
		column :times_completed

		column :created_at
		column :updated_at

		default_actions

	end
	#action_path

	# Memeber Methods
	member_action :toggle do
		level = Level.find(params[:id]);
		level.update_attribute("playable", !level.playable)
		redirect_to(:back)
	end
	#filter :playable, :as => :check_boxes
end


