package om;

#if js
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;

class ArrayBufferTools {
	/**
		Convert `js.lib.ArrayBuffer` to `String`.
	**/
	public static function toString(buf:ArrayBuffer):String {
		var v = new Uint8Array(buf);
		var s = "";
		for (i in 0...v.length)
			s += String.fromCharCode(v[i]);
		return s;
	}

	/**
		Convert `String` to `js.html.ArrayBuffer`.
	**/
	public static function toArrayBuffer(str:String):ArrayBuffer {
		var b = new ArrayBuffer(str.length);
		var v = new Uint8Array(b);
		for (i in 0...str.length)
			v[i] = str.charCodeAt(i);
		return b;
	}

	#if nodejs
	/**
		Convert `js.node.Buffer` to `js.html.ArrayBuffer`.
	**/
	public static function bufToArrayBuffer(buf:js.node.Buffer):ArrayBuffer {
		var a = new ArrayBuffer(buf.length);
		var v = new Uint8Array(a);
		for (i in 0...buf.length)
			v[i] = buf[i];
		return a;
	}
	#end
}
#end
