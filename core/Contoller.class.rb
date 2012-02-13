#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# Controller

class Controller

	def initialize data
		@data 		= data
		@rendered 	= false
	end

	def render view
		return false if @rendered

		name = view.capitalize + 'View'
		require VIEWS_PATH + DS_ + view + DS_ + name + '.class.rb'

		view = Object::const_get(name).new @data
		view.show
		
		@rendered = true
	end

	protected
	def load_model model
		name = model.capitalize + 'Model'
		require MODELS_PATH + DS_ + model + DS_ + name + '.class.rb'
		Object::const_get(name).new @data
	end
end