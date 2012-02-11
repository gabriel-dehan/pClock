#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Handles every sound output for the alarm

class AudioModel < Model
	def load_sound
		Gosu::Sample.new WINDOW, @data[:sound]
	end
end