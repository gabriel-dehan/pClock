#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Dispatcher : handles the request and config, loads the frontController


class Dispatcher

	# Retrieves the configuration file and loads data for the controller
	def initialize
		ini = IniConfig.new( BASE_PATH + DS_ + 'alarm.ini' )

		# Get data passed trough command-line
		arguments_data 	= Router::parse( ARGV )
		# Get data passed trough configuration file
		config_data		= Router::parse( ini )

		# Join both, keeping command-line data, filling up with config file data
		data			= Router::join( arguments_data, config_data )

		p data
	end

end