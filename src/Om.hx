
class Om {

	public static var console(get,never) : om.Console;
	static inline function get_console() {
		/*
		#if nodejs
		return js.Node.console;
		#elseif js
		return js.Browser.console;
		#elseif sys
		return om.Console.getInstance();
		#end
		*/
		return
			#if (sys||nodejs)
			om.Console.getInstance();
			#elseif js
			js.Browser.console;
			#end
	}

}
