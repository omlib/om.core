package om;

typedef URL =
	#if nodejs js.node.Url
	#elseif js js.html.URL
	#elseif doc_gen Dynamic
	#else #error
	#end;
