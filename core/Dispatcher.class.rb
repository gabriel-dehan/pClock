#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Dispatcher : handles the request and config, loads the frontController


class Dispatcher

	def initialize
		ini 	 = IniConfig.new( BASE_PATH + DS_ + 'alarm.ini' )
		ini_file = ini.document

		argumentsData 	= Router::parse( ARGV )
		configData		= Router::parse( ini_file )
	end

end