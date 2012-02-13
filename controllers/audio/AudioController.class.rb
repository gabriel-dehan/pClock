#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

#

class AudioController < Controller

	def execute
		render 'audio'

		model = load_model 'audio'
		sound = model.load_sound
	end
end