package om;

#if js

using om.Path;

class Browser {

	public static var supported(get,never):Bool;
	extern static inline function get_supported() return js.Syntax.typeof(window) != "undefined";

	public static var console(get,never) : js.html.ConsoleInstance;
	extern static inline function get_console() return window.console;

	public static var crypto(get,never) : js.html.Crypto;
	extern static inline function get_crypto() return window.crypto;

	public static var document(get,never) : js.html.HTMLDocument;
	extern static inline function get_document() return window.document;

	public static var navigator(get,never) : js.html.Navigator;
	extern static inline function get_navigator() return window.navigator;

	public static var history(get,never) : js.html.History;
	extern static inline function get_history() return window.history;

	public static var localStorage(get,never) : js.html.Storage;
	extern static inline function get_localStorage() return window.localStorage;

	public static var location(get,never) : js.html.Location;
	extern static inline function get_location() return window.location;

	public static var sessionStorage(get,never) : js.html.Storage;
	extern static inline function get_sessionStorage() return window.sessionStorage;

	public static var orientation(get,never) : Int;
	extern static inline function get_orientation() return window.orientation;

	public static var performance(get,never) : js.html.Performance;
	extern static inline function get_performance() return window.performance;

	public static var screen(get,never) : js.html.Screen;
	extern static inline function get_screen() return window.screen;

	public static var speechSynthesis(get,never) : js.html.SpeechSynthesis;
	extern static inline function get_speechSynthesis() return window.speechSynthesis;

	public static var window(get,never) : js.html.Window;
	extern static inline function get_window() return js.Syntax.code("window");

	public static inline function print() window.print();

	public static inline function alert( v : Dynamic )
		window.alert( Std.string(v) );

	/**
		Opens a 'Open File' dialog
	*/
	public static function openFile( callback : (files:js.html.FileList)->Void, ?accept : String, ?multiple : Bool ) {
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

	public static function saveTextFile( name : String, text : String ) {
		//var url = URL.createObjectURL( new js.html.Blob( [new js.lib.DataView(data)], { type: type } ) );
		var a = document.createAnchorElement();
		a.href = 'data:text/plain;charset=utf-8,' + StringTools.urlEncode( text );
		//a.href = 'data:text/plain' + StringTools.urlEncode( str );
		a.download = name;
		a.style.display = 'none';
		document.body.appendChild( a );
		a.click();
		document.body.removeChild( a );
	}

	public static function doClick( href : String ) {
		var a = document.createAnchorElement();
		a.href = href;
		a.style.display = 'none';
		document.body.appendChild( a );
		a.click();
		document.body.removeChild( a );
	}

}

#end