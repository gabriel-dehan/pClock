#!/usr/bin/ruby
#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

require './classes/Core.class'

Core::init

now = Time.now
puts "It's currently #{now.hour}:#{now.min}:#{now.sec}"