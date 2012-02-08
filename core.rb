#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

now = Time.now
puts "It's currently #{now.hour}:#{now.min}:#{now.sec}"

case ARGV[0]
	when '-t' then puts 'hello'
end
