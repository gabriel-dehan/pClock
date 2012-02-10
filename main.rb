#!/usr/bin/ruby
#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# main.rb : this is where it all begins

require './core/Core.class'
require './core/tools/Tools.class'

# Global constant declarations
BASE_PATH 	= Dir.getwd
DS_			= Tools::OS::is?( ['Darwin', 'Linux', 'BSD', 'Unix'] ) ? "/" : "\\"

Core::init

now = Time.now
puts "It's currently #{now.hour}:#{now.min}:#{now.sec}"

