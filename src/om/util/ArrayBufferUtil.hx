package om.util;

import js.html.ArrayBuffer;
import js.html.Uint8Array;

class ArrayBufferUtil {

	/**
		String to ArrayBuffer.
	*/
	public static function str2ab( str : String ) : ArrayBuffer {
		var b = new ArrayBuffer( str.length );
		var v = new Uint8Array( b );
		for( i in 0...str.length ) v[i] = str.charCodeAt( i );
		return b;
	}

	/**
		ArrayBuffer to String.
	*/
	public static function ab2str( buf : ArrayBuffer ) : String {
		var v = new Uint8Array( buf );
		var s = "";
		for( i in 0...v.length ) s += String.fromCharCode( v[i] );
		return s;
	}

}
