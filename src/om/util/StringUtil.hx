package om.util;

using om.util.ArrayUtil;

class StringUtil {

	/**
		Returns `true` if `source` contains one or more occurrences of `str`.
	*/
	public static inline function contains( source : String, str : String ) : Bool {
		#if php
		return str == "" || source.indexOf( str ) >= 0;
		#else
		return source.indexOf( str ) >= 0;
		#end
	}

	public static function containsAny( source : String, str : Array<String> ) : Bool
		return str.any( contains.bind( source, _ ) );

	public static inline function count( str : String, seperator = '' ) : Int
		return str.split( seperator ).length;

	public static inline function countLines( str : String ) : Int
		return count( str, '\n' );

	public static function quote( str : String ) : String {
		return
			if( str.indexOf( '"' ) < 0 ) '"' + str + '"';
			else if( str.indexOf( "'" ) < 0 ) "'" + str + "'";
			else '"' + StringTools.replace( str, '"', '\\"' ) + '"';
	}

	public static inline function removeLinebreaks( str : String ) : String
		return str.split( '\n' ).join( '' );

	public static inline function repeat( str : String, times : Int ) : String
		return [for(i in 0...times) str].join( '' );

	public static function reverse( str : String ) : String {
		var a = toArray( str );
    	a.reverse();
    	return a.join( '' );
	}

	public static inline function split( str : String, delimiter = '' ) : Array<String>
		return str.split( delimiter );

	public static inline function toArray( str : String, delimiter = '' ) : Array<String>
		return str.split( delimiter );
}
