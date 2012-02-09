#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

require 'iniparse'

class AlarmIniParse
	include IniParse
	# To change this template use File | Settings | File Templates.

	def initialize ini_path
		if File::exists? ini_path
			@ini_file = parse File.read ini_path
		end
	end

	def has_section? name
		@ini_file[name].nil? ? false : true
	end

	def has_key_for_section? section, name
		@ini_file[section][name].nil? ? false : true
	end

	def document
		@ini_file
	end
end