#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Core class, used for initialization

require 'sys/uname'
require 'find'
require 'gosu'

class Core
	@@classes = []

	def self.init
		self::register_autoloads
		self::loadClasses

		Dispatcher.new
	end

	private
	def self.register_autoloads
		in_path = BASE_PATH + '/core'
		p in_path
		Find::find( in_path ) { |file|
			@@classes << file if File::extname( file ).to_s == ".rb"
		}
	end

	def self.loadClasses
		@@classes.each { |c| require c }
	end
end