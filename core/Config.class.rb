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

		@config[:sound]  ||= ini.has_key_for_section?( 'Sounds', 'directory' )	? get_random_sound( ini_file ) : get_sound( ini_file )     if ini.has_section? 'Sounds'
		@config[:time]   ||= ini.has_key_for_section?( 'Time', 'at' ) 			? get_time( :at, ini_file )    : get_time( :in, ini_file ) if ini.has_section? 'Time'
		@config[:day]    ||= ini.has_key_for_section?( 'Days', 'on' ) 			? get_days( ini_file )         : (raise ArgumentError, 'Days section incomplete')   if ini.has_section? 'Days'
		@config[:cron]   ||= ini.has_key_for_section?( 'Crons', 'cron' )		? get_crons( ini_file )        : (raise ArgumentError, 'Crons section incomplete')  if ini.has_section? 'Crons'
		@config[:snooze] ||= ini.has_key_for_section?( 'Snooze', 'every' )		? ini_file['Snooze']['every']  : (raise ArgumentError, 'Snooze section incomplete') if ini.has_section? 'Snooze'

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

	def get_days( ini = nil )
		option_index = @args.find_index( '--on' )
		days = []
		if option_index
			option_index.next.upto @args.length do |i|
				break if /-[\w]|--[\w]+/ =~ @args[i]
				days << @args[i]
			end
			days.join(',')
		end
	end

	def get_sound( ini = nil )
		option_index = @args.find_index( '-s' )

		if option_index
			sound_file =  @args[option_index.next]
			return sound_file if File::file?( sound_file ) and /mp3|wma|aac|ogg|mp4|m4a/ =~ sound_file
		end
	end

	def get_random_sound( ini = nil )
		sounds    = []

		if not ini.nil?
			directory = ini['Sounds']['directory'].sample
		elsif
			option_index = @args.find_index( '-d' )
			directory    = @args[option_index.next]
			directory    = directory.end_with?( @ds ) ? directory : directory + @ds
		else
			raise ArgumentError
		end
		Find.find( directory ) { |f| sounds << f if /mp3|wma|aac|ogg|mp4|m4a/ =~ f 	}

		sounds.sample()
	end

	def get_time( opt, ini = nil )
		option_index = @args.find_index( '--' + opt.to_s )
		desired_time = @args[option_index.next].split ( ':' )
		now = Time.now

		if opt === :at
			Time::mktime( now.year, now.month, now.day, desired_time[0].to_i, desired_time[1].to_i, desired_time[2].to_i )
		elsif opt === :in
			now + (desired_time[0].to_i * 60 * 60) + (desired_time[1].to_i * 60) + desired_time[2].to_i
		end
	end

	def get_crons( ini = nil )
		
	end
end