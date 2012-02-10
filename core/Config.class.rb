#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Configuration singleton for the project

require 'singleton'
require 'find'

class CoreConfig
	include Singleton
	
	attr_reader :ds, :base_path, :config
	
	def initialize
		@args   	= ARGV
		@config 	= {}
		@ds     	= Tools::OS::is?( ['Darwin', 'Linux', 'BSD', 'Unix'] ) ? "/" : "\\"
		@base_path 	= Dir.getwd
		ini_path    = @base_path + @ds + 'alarm.ini'

		ini 	 = IniConfig.new ini_path
		ini_file = ini.document

		parse_args
	end

	private
	def parse_args
		@args.each do |arg|
			@config[:sound] ||=
					if arg == '-d' or arg == '--directory'
						get_random_sound
					elsif arg == '-s' or arg == '--sound'
						get_sound
					end

			@config[:time] ||=
					if arg == '--at'
						get_time :at
					elsif arg == '--in'
						get_time :in
					end

			@config[:days] ||=
					if arg == '--on'
						get_days
					end

			@config[:snooze] ||=
					if arg == '--snooze'
						@args[@args.find_index('--snooze').next]
					end
		end # @args.each |arg|

		# Default values
		if @config[:sound].nil?;  @config[:sound]  = @base_path + @ds + 'alarm' + @ds + 'alarm.mp3' end
		if @config[:snooze].nil?; @config[:snooze] = 5 end
		if @config[:time].nil?;   raise ArgumentError, 'Time argument unknown' end
	end


end