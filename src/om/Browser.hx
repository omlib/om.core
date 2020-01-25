package om;

/*
#if (sys||macro) #else
typedef Browser = js.Browser;
#end
*/

#if js

import js.html.FileList;

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

	/**
		Opens a 'Open File' dialog
	*/
	public static function openFile( callback : (files:FileList)->Void, ?accept : String, ?multiple : Bool ) {
		var input = document.createInputElement();
		input.type = 'file';
		input.accept = accept;
		input.multiple = multiple;
		input.onchange = e -> callback( e.target.files );
		input.click();
	}

	/**
		Opens a 'Save File' dialog.
	*/
	public static function saveFile( name : String, data : js.lib.ArrayBuffer, type = 'octet/stream' ) {
		var url = URL.createObjectURL( new js.html.Blob( [new js.lib.DataView(data)], { type: type } ) );
		var a = document.createAnchorElement();
		a.href = url;
		a.download = name;
		a.click();
		URL.revokeObjectURL( url );
	}
	
}

#end