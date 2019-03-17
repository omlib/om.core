package om;

typedef Thread =
	#if (cpp||hl||java||neko||php||python)
		sys.thread.Thread;
	#elseif (cs||lua)
		Dynamic; //TODO
	#elseif doc_gen
		Dynamic;
	#else
		#error
	#end
