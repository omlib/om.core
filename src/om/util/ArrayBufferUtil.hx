package om.util;

#if js

import js.html.ArrayBuffer;
import js.html.Uint8Array;

class ArrayBufferUtil {

	/**
		js.html.ArrayBuffer to String.
	*/
	public static function ab2str( buf : ArrayBuffer ) : String {
		var v = new Uint8Array( buf );
		var s = "";
		for( i in 0...v.length ) s += String.fromCharCode( v[i] );
		return s;
	}

	#if nodejs

	/**
		js.node.Buffer to js.html.ArrayBuffer.
	*/
	public static function buf2ab( buf : js.node.Buffer ) : ArrayBuffer {
		var ab = new ArrayBuffer( buf.length );
		var view = new Uint8Array(ab);
		for( i in 0...buf.length ) view[i] = buf[i];
		return ab;
	}

	#end

	/**
		String to js.html.ArrayBuffer.
	*/
	public static function str2ab( str : String ) : ArrayBuffer {
		var b = new ArrayBuffer( str.length );
		var v = new Uint8Array( b );
		for( i in 0...str.length ) v[i] = str.charCodeAt( i );
		return b;
	}

}
#end
