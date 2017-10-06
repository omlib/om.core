package om.util;

#if js

import js.html.ArrayBuffer;
import js.html.Uint8Array;

class ArrayBufferUtil {

	/**
		Convert js.html.ArrayBuffer to String.
	*/
	public static function ab2str( buf : ArrayBuffer ) : String {
		var v = new Uint8Array( buf );
		var s = "";
		for( i in 0...v.length ) s += String.fromCharCode( v[i] );
		return s;
	}

	#if nodejs

	/**
		Convert js.node.Buffer to js.html.ArrayBuffer.
	*/
	public static function buf2ab( buf : js.node.Buffer ) : ArrayBuffer {
		var a = new ArrayBuffer( buf.length );
		var v = new Uint8Array( a );
		for( i in 0...buf.length ) v[i] = buf[i];
		return a;
	}

	#end

	/**
		Convert String to js.html.ArrayBuffer.
	*/
	public static function str2ab( str : String ) : ArrayBuffer {
		var b = new ArrayBuffer( str.length );
		var v = new Uint8Array( b );
		for( i in 0...str.length ) v[i] = str.charCodeAt( i );
		return b;
	}

}
#end
