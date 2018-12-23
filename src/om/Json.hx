package om;

class Json {

	public static inline function parse( str : String ) : Dynamic {
		return haxe.Json.parse( str );
	}

	public static inline function stringify( v : Dynamic, ?replacer : (key:Dynamic,value:Dynamic)->Dynamic, ?space : String  ) : String {
		return haxe.Json.stringify( v, replacer, space );
	}

	#if (sys||nodejs)

	public static inline function parseFile( path : String ) : Dynamic {
		return haxe.Json.parse( sys.io.File.getContent( path ) );
	}

	#end
}
