#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Core class, used for initialization
require 'sys/uname'
require 'gosu'

class Core
	def self.init
		self::autoload
		config = CoreConfig::instance.config
		p "---------------------------------"
		p config
	end

	private
	def self.autoload
		class_directory_name = Dir::getwd + '/classes/'
		class_directory = Dir::new( class_directory_name )
		class_directory.each do |s_class|
		require class_directory_name + s_class if File::extname( s_class ).to_s == ".rb"
		end
	end
end