#
# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#

# A convenient class for general purposes


module Tools
	class OS
		# Author:: Kal (http://bka-bonn.de/wordpress/index.php/2009/06/01/determine-os-with-ruby)
		def self.is? ( os )
			if @os_name.nil?
				begin # use Sys::Uname library if present
					@os_name 		= Sys::Uname.sysname
					@architecture = Sys::Uname.machine
					@os_version 	= Sys::Uname.release
				rescue # otherwise use shell
					@os_name 		= `uname -s`.strip
					@architecture 	= `uname -p`.strip
					@os_version 	= `uname -r`.strip
				end
			end
			
			return os.is_a?( Array ) ? os.include?( @os_name ) : os == @os_name
		end
	end
end