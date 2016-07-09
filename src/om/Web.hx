package om;

#if sys

@experimental
typedef Web =
	#if neko
		neko.Web;
	#elseif php
		php.Web;
	#end

#end
