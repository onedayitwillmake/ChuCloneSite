ENV['RAILS_ENV'] ||= 'production'

# Load the rails application
require File.expand_path('../application', __FILE__)

module OpenSSL
	module SSL
		remove_const :VERIFY_PEER
	end
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Initialize the rails application
ChuCloneSite::Application.initialize!

