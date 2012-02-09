#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Config class for the whole project

require 'find'

class CoreConfig
	attr_reader :ds
	
	def initialize args
		@args   = args
		@config = {}
		@ds     = Tools::OS::is?( ['Darwin', 'Linux', 'BSD', 'Unix'] ) ? "/" : "\\"

		@args.each do |arg|
			@config[:sound] = case arg
				when '-d' then get_random_sound
				when '--directory' then get_random_sound
				when '-s' then get_sound
				when '--sound' then get_sound
				else 'Default sound path' # TODO: Rajouter un default sound path
			end

			@config[:time] = case arg
				when '--at' then get_time :at
				when '--in' then get_time :in
			end
		end
	end

	private
	def get_sound
		option_index = @args.find_index( '-s' )

		if option_index
			sound_file =  @args[option_index.next]
			return sound_file if File::file?( sound_file ) and /mp3|wma|aac|ogg|mp4/ =~ sound_file
		end
	end

	def get_random_sound
		option_index = @args.find_index( '-d' )

		if option_index
			sounds    = []
			directory =  @args[option_index.next]
			directory = directory.end_with?( @ds ) ? directory : directory + @ds

			Find.find( directory ) { |f| sounds << f if /mp3|wma|aac|ogg|mp4/ =~ f 	}
		else
			raise ArgumentError, 'No `-d` argument sent to the process'
		end
		sound.sample
	end

	def get_time opt
		option_index = @args.find_index( '--' + opt.to_s )
		desired_time = @args[option_index.next].split ( ':' )
		now = Time.now

		if opt === :at
			Time::mktime( now.year, now.month, now.day, desired_time[0].to_i, desired_time[1].to_i, desired_time[2].to_i )
		elsif opt === :in
			now + (desired_time[0].to_i * 60 * 60) + (desired_time[1].to_i * 60) + desired_time[2].to_i
		end
	end
end