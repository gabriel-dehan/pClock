#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Router


class Router

	def self.parse ( params )
		if ( params.is_a? Array ) then
			self.parse_args params
		else
			self.parse_config params
		end
	end

	private
	def self.parse_args args
		data = {}

		@args.each do |arg|
			data[:sound] ||=
					if arg == '-d' or arg == '--directory'
						get_random_sound
					elsif arg == '-s' or arg == '--sound'
						get_sound
					end

			data[:time] ||=
					if arg == '--at'
						get_time :at
					elsif arg == '--in'
						get_time :in
					end

			data[:days] ||=
					if arg == '--on'
						get_days
					end

			data[:snooze] ||=
					if arg == '--snooze'
						@args[@args.find_index('--snooze').next]
					end
		end # @args.each |arg|

		# Default values
		if data[:sound].nil?;  data[:sound]  = @base_path + @ds + 'alarm' + @ds + 'alarm.mp3' end
		if data[:snooze].nil?; data[:snooze] = 5 end
		if data[:time].nil?;   raise ArgumentError, 'Time argument unknown' end
	end

	def self.parse_config file
		
	end
end