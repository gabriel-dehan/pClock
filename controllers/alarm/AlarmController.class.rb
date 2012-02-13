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
		snooze_job	= nil

		scheduled << scheduler.at( @data[:time] ) do |job|
			# Sound play

			
			while remaining
				if STDIN.gets == "\n"
					# Sound pause
					snooze_job = snooze( remaining )
					remaining -= 1
				else
					# Sound pause
					snooze_job.unschedule unless snooze_job.nil?
					break
				end
			end

			scheduled.delete job
			job.unschedule
		end

		@data[:cron].each { |cron|
			scheduled << scheduler.cron( cron ) do |job|
				# Sound play

				scheduled.delete job
				job.unschedule
			end
		}
		#scheduled << scheduler.cron @data[:cron] do

		until scheduled.empty?; end
		#Rufus.parse_time_string s
	end

	private
	def snooze remaining
		p 'snooze'
		schedule_snooze = Rufus::Scheduler.start_new
		minutes			= @data[:snooze].to_s + 'm'
		
		schedule_snooze.every minutes do |snooze_job|
			# Sound play
			snooze_job.unschedule if remaining.zero?
		end
	end
end