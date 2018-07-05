package om;

typedef Thread =
	#if cpp
		cpp.vm.Thread;
	//#elseif hl
	//	hl.vm.Thread;
	#elseif java
		java.vm.Thread;
	#elseif lua
		lua.Thread;
	#elseif neko
		neko.vm.Thread;
	#elseif doc_gen
		Dynamic;
	#else
		#error
	#end
