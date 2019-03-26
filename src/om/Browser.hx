package om;

/*
#if (sys||macro) #else
typedef Browser = js.Browser;
#end
*/

#if js

class Browser {

	public static var window(get,never) : js.html.Window;
	extern static inline function get_window() return untyped __js__("window");
	
	public static var document(get,never) : js.html.HTMLDocument;
	extern static inline function get_document() return window.document;
	
	public static var navigator(get,never) : js.html.Navigator;
	extern static inline function get_navigator() return window.navigator;
	
	public static var console(get,never) : js.html.ConsoleInstance;
	extern static inline function get_console() return window.console;
	
	public static var history(get,never) : js.html.History;
	extern static inline function get_history() return window.history;
	
	public static inline function print() window.print();

	//public static var supported(get, never):Bool;
	//extern inline static function get_supported() return js.Syntax.typeof(window) != "undefined";

	/*
	public static function alert( v : Dynamic ) {
		@:privateAccess window.alert(Boot.__string_rec(v,""));
	}
	*/
	
}

#end