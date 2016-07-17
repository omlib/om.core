package om;

typedef Thread =
	#if cpp cpp.vm.Thread;
	#elseif java java.vm.Thread;
	#elseif neko neko.vm.Thread;
	#else #error 'not implemented'
	#end
