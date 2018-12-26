package om;

// TODO ....

#if (js&&!nodejs)
typedef Console = js.html.ConsoleInstance;

#elseif (sys||nodejs)

/// node is missing some features (clear,debug,..) there using this

//@:noDoc
@defines('no_console','Remove calls to om.Console')
#if no_console @exclude #end
class Console {

	static var instance : om.Console;

	public static function getInstance() : om.Console {
		return (instance == null) ? instance = new om.Console() : instance;
	}

	public static inline function print( s : String ) {
		Sys.print( s );
	}

	public static inline function println( s : String ) {
		Sys.println( s );
	}

	function new() {}

	public inline function debug( data : String ) {
		//TODO
	}

	public inline function log( data : String ) {
		println( data );
	}

	public inline function info( data : String ) {
		println( data );
	}

	public inline function warn( data : String ) {
		println( data );
	}

	public inline function error( data : String ) {
		println( data );
	}

	public inline function clear() {
		print( '\033c' );
	}

	// TODO ...
	
}

#end
