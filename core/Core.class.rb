#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Gems requirements
require 'sys/uname'
require 'find'
require 'gosu'

# Core class, used for initialization

class Core
	@@autoloads = []

	# Loads every class in './core/' and loads the Dispatcher
	def self.init
		self::register_autoloads 'core'
		self::register_autoloads 'lib'

		self::autoload

		Dispatcher.new
	end

	private
	def self.register_autoloads dir
		all_in_core = BASE_PATH + DS_ + dir

		Find::find( all_in_core ) { |file|
			@@autoloads << file if File::extname( file ).to_s == ".rb"
		}
	end

	def self.autoload
		@@autoloads.each { |c| require c }
	end

end