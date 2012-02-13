#!/usr/bin/ruby
#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# main.rb : this is where it all begins

require './core/Core.class'
require './core/tools/Tools.class'

# Global constant declarations
DS_					= Tools::OS::is?( ['Darwin', 'Linux', 'BSD', 'Unix'] ) ? "/" : "\\"
BASE_PATH			= Dir.getwd
VIEWS_PATH			= BASE_PATH + DS_ + 'views/'
CONTROLLERS_PATH	= BASE_PATH + DS_ + 'controllers/'
MODELS_PATH			= BASE_PATH + DS_ + 'models/'
TIME_BUFFER			= 1
WINDOW				= Gosu::Window.new(1, 1, false)

Core::init



