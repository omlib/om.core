package om;

typedef Thread =
	#if cpp
		cpp.vm.Thread;
	#elseif java
		java.vm.Thread;
	#elseif lua
		lua.Thread;
	#elseif neko
		neko.vm.Thread;
	#elseif doc
		Dynamic;
	#else
		#error
	#end
