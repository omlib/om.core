package om;

typedef Thread =
	//#if (cpp||hl||java||neko||php||python)
	#if (cpp||hl||java||neko)
		sys.thread.Thread;
	//#elseif (cs||lua)
	//	Dynamic; //TODO
	//#elseif doc_gen
	#else
		Dynamic;
	//#else
	//	#error
	#end
