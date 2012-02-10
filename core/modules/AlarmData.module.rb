#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Module AlarmData : holds convenience methods for Routeur data parsing


module AlarmData

	def self.init_with_args args
		@args = args
	end

	def self.get_days( ini = nil )
		# Using configuration file ?
		if not ini.nil?
			days_section = ini['Days']['on']
			return ( days_section.is_a? Array ) ? days_section.first : days_section

		# Using command-line arguments ?
		else
			begin
				option_index = @args.find_index( '--on' )
			rescue
				raise ArgumentError 'Day option not found'
			end
			days 		 = []

			option_index.next.upto @args.length do |i|
				break if /-[\w]|--[\w]+/ =~ @args[i]
				days << @args[i]
			end

			return days.join(',')
		end # if ini.nil?
	end

	def self.get_sound( ini = nil )
		# Using configuration file ?
		if not ini.nil?
			sound_section = ini['Sounds']['file']
			sound_file = ( sound_section.is_a? Array ) ? sound_section.sample : sound_section

		# Using command-line arguments ?
		else
			begin
				option_index = @args.include?( '-s' ) ? @args.find_index( '-s' ) : @args.find_index( '--sound' )
			rescue
				raise ArgumentError 'Sound option not found'
			end
			sound_file =  @args[option_index.next]
		end # if ini.nil?

		return sound_file if File::file?( sound_file ) and /mp3|wma|aac|ogg|mp4|m4a/ =~ sound_file
	end

	def self.get_random_sound( ini = nil )
		sounds    = []

		# Using configuration file ?
		if not ini.nil?
			directory_section = ini['Sounds']['directory']
			directory = ( directory_section.is_a? Array ) ? directory_section.sample : directory_section

		# Using command-line arguments ?
		else
			begin
				option_index = @args.include?( '-d' ) ? @args.find_index( '-d' ) : @args.find_index( '--directory' )
			rescue
				raise ArgumentError 'Directory option not found'
			end
			
			directory    = @args[option_index.next]
			directory    = directory.end_with?( DS_ ) ? directory : directory + DS_
		end # if ini.nil?

		Find.find( directory ) { |f| sounds << f if /mp3|wma|aac|ogg|mp4|m4a/ =~ f 	}

		return sounds.sample()
	end

	def self.get_time( opt, ini = nil )
		now = Time.now

		# Using configuration file ?
		if not ini.nil?
			time_section = ini['Time'][opt.to_s]
			desired_time = ( time_section.is_a? Array ) ? time.sample.split( ':' ) : time_section.split( ':' )

		# Using command-line arguments ?
		else
			begin
				option_index = @args.find_index( '--' + opt.to_s )
			rescue
				raise ArgumentError 'Time option not found'
			end
			desired_time = @args[option_index.next].split ( ':' )
		end # if ini.nil?

		if opt === :at
			return Time::mktime( now.year, now.month, now.day, desired_time[0].to_i, desired_time[1].to_i, desired_time[2].to_i )
		elsif opt === :in
			return now + (desired_time[0].to_i * 60 * 60) + (desired_time[1].to_i * 60) + desired_time[2].to_i
		end
	end

	def self.get_snooze( ini = nil )
		# Using configuration file ?
		if not ini.nil?
			snooze_section = ini['Snooze']['every']
			return ( snooze_section.is_a? Array ) ? snooze_section.sample.to_i : snooze_section.to_i

		# Using command-line arguments ?
		else
			begin
				return @args[@args.find_index('--snooze').next].to_i
			rescue
				raise ArgumentError 'Snooze option not found'
			end
		end
	end

	def self.get_crons( ini )
		# Using configuration file
		ini['Crons']['cron'].to_a
	end
end