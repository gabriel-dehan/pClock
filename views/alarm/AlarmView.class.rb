#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Handles the display for the alarm clock

class AlarmView < View

	def show
		now = Time.now

		puts "Time  : #{now.hour}:#{now.min}:#{now.sec}"

		puts "Alarm : #{@data[:time].hour}:#{@data[:time].min}:#{@data[:time].sec}" unless @data[:time].nil?


		@data[:cron].each { |cron|
			puts "Cron  : #{cron}"
		} unless @data[:cron].nil?

	end
end