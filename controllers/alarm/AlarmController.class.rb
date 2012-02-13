#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# This class handles all the Alarm functionalities

class AlarmController < Controller

	def execute
		render 'alarm'

		scheduler	= Rufus::Scheduler.start_new
		scheduled	= []
		remaining	= 5

		scheduled << scheduler.at( @data[:time] ) do |job|
			remaining	= 5

			play
			snooze( remaining )

			scheduled.delete job
			job.unschedule
		end

		@data[:cron].each { |cron|
			scheduled << scheduler.cron( cron ) do |job|
				remaining	= 5

				play
				snooze( remaining )

				scheduled.delete job
				job.unschedule
			end
		}

		until scheduled.empty? || /e|x|exit|leave|quit|q/ =~ STDIN.gets; end
	end

	private
	def snooze remaining
		schedule_snooze = Rufus::Scheduler.start_new
		snooze_job		= nil
		minutes			= @data[:snooze].to_s + 's'

		while remaining >= 0
			if STDIN.gets == "\n"

				@playing.pause

				snooze_job = schedule_snooze.in minutes do |job|
					@playing.resume
					puts "Snooze in #{minutes}"

					job.unschedule if remaining.zero?
				end
				
				remaining -= 1
			else
				@playing.stop
				snooze_job.unschedule unless snooze_job.nil?
				break
			end
		end
	end

	def play
		@playing = @data[:gosu_sound].play()

		puts "Playing #{@data[:sound]}"
	end

end