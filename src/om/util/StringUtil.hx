package om.util;

using om.util.ArrayUtil;

class StringUtil {

	//public static var SPLIT_LINES = ~/\r\n|\n\r|\n|\r/g;

	/**
		Returns `true` if `src` contains one or more occurrences of `str`.
	*/
	public static inline function contains( src : String, str : String ) : Bool {
		#if php
		return str == "" || src.indexOf( str ) >= 0;
		#else
		return src.indexOf( str ) >= 0;
		#end
	}

	public static function containsAny( src : String, str : Array<String> ) : Bool {
		return str.any( contains.bind( src, _ ) );
	}

	public static inline function count( str : String, seperator = '' ) : Int {
		return str.split( seperator ).length;
	}

	public static inline function countLines( str : String ) : Int {
		return count( str, '\n' );
	}

	public static inline function isEmpty( str : String ) : Bool {
		return str == null || str == '';
	}

	public static inline function isLowerCase( str : String ) : Bool {
		return str.toLowerCase() == str;
	}

	public static inline function isUpperCase( str : String ) : Bool {
		return str.toUpperCase() == str;
	}

	public static inline function lines( str : String ) : Array<String> {
		//return SPLIT_LINES.split( str );
		return ~/\r\n|\n\r|\n|\r/g.split( str );
	}

	public static function parseFloat( f : Float, ?precision : Null<Int> ) : String {
	    if( precision == null )
	        return Std.string( f );
	    if( precision < 0 )
			throw 'invalid precision';
		var s = Std.string( f );
        var i = s.indexOf( '.' );
        if( i == -1 )
            return s;
        if( precision == 0 )
            return s.substr( 0, i );
        return s.substr( 0, i + 1 + precision );
    }

	public static function quote( str : String ) : String {
		return
			if( str.indexOf( '"' ) < 0 ) '"' + str + '"';
			else if( str.indexOf( "'" ) < 0 ) "'" + str + "'";
			else '"' + StringTools.replace( str, '"', '\\"' ) + '"';
	}

	public static inline function removeLinebreaks( str : String ) : String {
		return str.split( '\n' ).join( '' );
	}

	public static inline function repeat( str : String, times : Int ) : String {
		return [for(i in 0...times) str].join( '' );
	}

	/*
	public static function replace( str : String, expr : String, newStr : String ) : String {
		#if js
		return untyped str.replace( expr, newStr );
	}
	*/

	public static function reverse( str : String ) : String {
		var a = toArray( str );
    	a.reverse();
    	return a.join( '' );
	}

	public static inline function split( str : String, delimiter = '' ) : Array<String> {
		return str.split( delimiter );
	}

	public static inline function toArray( str : String, delimiter = '' ) : Array<String> {
		return str.split( delimiter );
	}
}
