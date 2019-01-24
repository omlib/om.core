package om;

using om.ArrayTools;

class StringTools {

	public static inline function htmlEscape( s : String, ?quotes : Bool ) : String return std.StringTools.htmlEscape( s, quotes );
	public static inline function htmlUnescape( s : String ) : String return std.StringTools.htmlUnescape( s );
	//public static inline function postProcessUrlEncode( s : String ) : String return std.StringTools.postProcessUrlEncode( s );
	public static inline function urlEncode( s : String ) : String return std.StringTools.urlEncode( s );
	public static inline function urlDecode( s : String ) : String return std.StringTools.urlDecode( s );
	public static inline function startsWith( s : String, start : String ) : Bool return std.StringTools.startsWith( s, start );
	public static inline function endsWith( s : String, end : String ) : Bool return std.StringTools.endsWith( s, end );
	public static inline function isSpace( s : String, pos : Int ) : Bool return std.StringTools.isSpace( s, pos );
	public static inline function ltrim( s : String ) : String return std.StringTools.ltrim( s );
	public static inline function rtrim( s : String ) : String return std.StringTools.rtrim( s );
	public static inline function trim( s : String ) : String return std.StringTools.trim( s );
	public static inline function lpad( s : String, c : String, l : Int ) : String return std.StringTools.lpad( s, c, l );
	public static inline function rpad( s : String, c : String, l : Int ) : String return std.StringTools.rpad( s, c, l );
	public static inline function replace( s : String, sub : String, by : String ) : String return std.StringTools.replace( s, sub, by );
	public static inline function hex( n : Int, ?digits : Int ) : String return std.StringTools.hex( n, digits );
	public static inline function fastCodeAt( s : String, index : Int ) : Int return std.StringTools.fastCodeAt( s, index );
	public static inline function isEof( c : Int ) : Bool return std.StringTools.isEof( c );
	public static inline function quoteUnixArg( argument : String ) : String return std.StringTools.quoteUnixArg( argument );
	public static inline function quoteWinArg( argument : String, escapeMetaCharacters : Bool ) : String return std.StringTools.quoteWinArg( argument, escapeMetaCharacters );

	//public static var SPLIT_LINES = ~/\r\n|\n\r|\n|\r/g;

	public static function capitalize( str : String ) : String {
		return str.charAt( 0 ).toUpperCase() + str.substr( 1 );
		//return ~/\S/.replace( str, "$1".toUpperCase() );
	}

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

	public static function fromIntArray( a : Array<Int> ) : String {
		var r = [];
		for( i in 0...a.length ) {
	        var c = a[i];
	        if( c > 255 ) c &= 255;
	        r.push( String.fromCharCode( c ) );
	    }
	    return r.join( "" );
	}

	public static inline function hasUpperCase( s : String ) : Bool {
		return s != s.toLowerCase();
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

	public static inline function map<T>( str : String, cb : String->T ) : Array<T> {
		return toArray( str ).map( cb );
	}

	public static function parseFloat( f : Float, ?precision : Null<Int> ) : String {
	    if( precision == null )
	        return Std.string( f );
	    if( precision < 0 )
			return throw 'invalid precision';
		var s = Std.string( f );
        var i = s.indexOf( '.' );
        if( -1 == i )
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

	public static inline function removeLinebreaks( s : String ) : String {
		return s.split( '\n' ).join( '' );
	}

	public static inline function repeat( s : String, n : Int ) : String {
		return [for(i in 0...n) s].join( '' );
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

	public static function toIntArray( s : String ) : Array<Int> {
		var r = new Array<Int>();
		for( i in 0...s.length )
			r.push( s.charCodeAt( i ) );
		return r;
	}

	#if js

	public static function createRandomString( length : Int ) : String {
		#if doc_gen
		return null;
		#elseif nodejs
        return js.node.Crypto.randomBytes( length ).toString( 'hex' ).substr( 0, length );
        #elseif js
        var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        var values = new js.html.Uint32Array( length );
        om.Browser.window.crypto.getRandomValues( values );
        var str = "";
        for( i in 0...length ) str += charset.charAt( values[i] % charset.length );
        return str;
		#else #error
        #end
    }

	#end

}
