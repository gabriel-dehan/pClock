#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

#

class FrontController < Controller

	def execute
		model = load_model 'audio'
		sound = model.load_sound
	end
end