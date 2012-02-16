#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Dispatcher : handles the request and config, loads controllers

class Dispatcher

	# Retrieves the configuration file and loads data for the controller
	def initialize
		ini = IniConfig.new( BASE_PATH + DS_ + 'alarm.ini' )

		# This should be in a view, but...
		puts 'Loading configuration...'
		
		# Get data passed trough command-line
		arguments_data 	= Router::parse( ARGV )
		# Get data passed trough configuration file
		config_data		= Router::parse( ini )

		# Join both, keeping command-line data, filling up with config file data
		@data			= Router::join( arguments_data, config_data )

		controller			= load_controller 'audio'
		@data[:gosu_sound]	= controller.execute

		# This should be in a view, but...
		puts '[Ready]'
		controller		= load_controller 'alarm'
		controller.execute
	end

	private
	def load_controller controller
		name = controller.capitalize + 'Controller'
		require CONTROLLERS_PATH + DS_ + controller + DS_ + name + '.class.rb'
		Object::const_get( name ).new @data
	end

end