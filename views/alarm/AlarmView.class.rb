#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Handles the display for the alarm clock

class AlarmView < View

	def show
		now = Time.now

		puts
		puts "Time  : #{format_time now}"

		puts "Alarm : #{format_time @data[:time]}" unless @data[:time].nil?


		@data[:cron].each { |cron|
			puts "Cron  : #{cron}"
		} unless @data[:cron].nil?

	end

	def format_time time
		hours   = ( (time.hour < 10) ? '0' : '' ) + time.hour.to_s
		minutes = ( (time.min  < 10) ? '0' : '' ) + time.min.to_s
		seconds = ( (time.sec  < 10) ? '0' : '' ) + time.sec.to_s

		hours + ':' +  minutes + ':' + seconds
	end
end