#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Router

class Router

	def self.parse ( params )
		# If params are an Array, it comes from command-line,
		# otherwise from configuration file
		if ( params.is_a? Array ) then
			self.parse_args params
		else
			self.parse_config params
		end
	end

	private
	def self.parse_args args
		include AlarmData
		AlarmData::init_with_args args

		data = {}

		# Fill up data{} according to command-line arguments
		args.each do |arg|
			data[:sound] ||=
					if arg == '-d' or arg == '--directory'
						AlarmData::get_random_sound
					elsif arg == '-s' or arg == '--sound'
						AlarmData::get_sound
					end

			data[:time] ||=
					if arg == '--at'
						AlarmData::get_time :at
					elsif arg == '--in'
						AlarmData::get_time :in
					end

			data[:days] ||=
					if arg == '--on'
						AlarmData::get_days
					end

			data[:snooze] ||=
					if arg == '--snooze'
						AlarmData::get_snooze
					end
		end # args.each |arg|

		return data
	end

	def self.parse_config ini
		ini_file = ini.document
		data	 = {}

		# Fill up data according to configuration file content
		data[:sound]  ||= ( ini.has_key_for_section?( 'Sounds', 'directory' ) &&
											!ARGV.include?( '--use-sound' ) )	? AlarmData::get_random_sound( ini_file ) : AlarmData::get_sound( ini_file )					if ini.has_section? 'Sounds'
		data[:time]   ||= ini.has_key_for_section?( 'Time', 'at' )				? AlarmData::get_time( :at, ini_file )    : AlarmData::get_time( :in, ini_file )				if ini.has_section? 'Time'
		data[:days]    ||= ini.has_key_for_section?( 'Days', 'on' )				? AlarmData::get_days( ini_file )         : (raise ArgumentError, 'Days section incomplete')	if ini.has_section? 'Days'
		data[:cron]   ||= ini.has_key_for_section?( 'Crons', 'cron' )			? AlarmData::get_crons( ini_file )		  : (raise ArgumentError, 'Crons section incomplete')	if ini.has_section? 'Crons'
		data[:snooze] ||= ini.has_key_for_section?( 'Snooze', 'every' )			? AlarmData::get_snooze( ini_file )		  : (raise ArgumentError, 'Snooze section incomplete')	if ini.has_section? 'Snooze'

		return data
	end

	# Merge and sets default values for data arrays
	def self.join( primary, secondary )

		# Primary array erase secondary value unless primary value is nil
		data = secondary.merge( primary ) { |k, ov, nv| nv.nil? ? ov : nv }
		
		# Sets up default values
		if data[:sound].nil?;  data[:sound]  = BASE_PATH + DS_ + 'alarm' + DS_ + 'alarm.mp3' end
		if data[:snooze].nil?; data[:snooze] = 5 end
		if data[:time].nil?;   raise ArgumentError, 'Time argument unknown' end

		return data
	end
end