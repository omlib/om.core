package om;

typedef URL =
	#if nodejs
		js.node.Url
	#elseif js
		js.html.URL
	#elseif doc
		Dynamic
	#else
		#error
	#end;
