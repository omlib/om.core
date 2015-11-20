package om.util;

import js.html.ArrayBuffer;

class ArrayBufferUtil {

	/**
		str2ab
	*/
	public static function str2ab( str : String ) : ArrayBuffer {
		var b = new ArrayBuffer( str.length );
		var v = new js.html.Uint8Array( b );
		for( i in 0...str.length ) v[i] = str.charCodeAt( i );
		return b;
	}

	/**
		ab2str
	*/
	public static function ab2str( buf : ArrayBuffer ) : String {
		var v = new js.html.Uint8Array( buf );
		var s = "";
		for( i in 0...v.length ) s += String.fromCharCode( v[i] );
		return s;
	}

	/*
	public static function toArrayBuffer( t : String, cb : ArrayBuffer->Void ) {
		var bb = new BlobBuilder();
		bb.append(t);
		var f = new FileReader();
		f.onload = function(e) {
			cb(e.target.result);
		}
		f.readAsArrayBuffer(bb.getBlob());
	}

	public static function toString( b : ArrayBuffer, cb : String->Void ) {
		var bb = new BlobBuilder();
		bb.append(b);
		var f = new FileReader();
		f.onload = function(e) {
			cb(e.target.result);
		}
		f.readAsText(bb.getBlob());
	}
	*/

}
