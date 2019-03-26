
import om.ArrayBufferTools;
import utest.Assert.*;
#if js
#if (haxe_ver >= 4)
import js.lib.Uint8Array;
#else
import js.html.Uint8Array;
#end
#end

class TestArrayBufferTools extends utest.Test {

	#if js

	function test_ab2str() {
		var str = 'disktree';
		var ab = ArrayBufferTools.str2ab( str );
		str = ArrayBufferTools.ab2str( ab );
		var view = new Uint8Array( ab );
		equals( 8, view.length );
		equals( str.charCodeAt(0), view[0] );
		equals( str.charCodeAt(1), view[1] );
		equals( str.charCodeAt(2), view[2] );
		equals( str.charCodeAt(3), view[3] );
		equals( str.charCodeAt(4), view[4] );
		equals( str.charCodeAt(5), view[5] );
		equals( str.charCodeAt(6), view[6] );
		equals( str.charCodeAt(7), view[7] );
	}

	#if nodejs

	function test_buf2ab() {
		var str = 'disktree';
		var ab = new js.node.Buffer( str );
		var view = new Uint8Array( ab );
		equals( 8, view.length );
		equals( str.charCodeAt(0), view[0] );
		equals( str.charCodeAt(1), view[1] );
		equals( str.charCodeAt(2), view[2] );
		equals( str.charCodeAt(3), view[3] );
		equals( str.charCodeAt(4), view[4] );
		equals( str.charCodeAt(5), view[5] );
		equals( str.charCodeAt(6), view[6] );
		equals( str.charCodeAt(7), view[7] );
	}

	#end

	function test_str2ab() {
		var str = 'disktree';
		var ab = ArrayBufferTools.str2ab( str );
		var view = new Uint8Array( ab );
		equals( 8, view.length );
		equals( str.charCodeAt(0), view[0] );
		equals( str.charCodeAt(1), view[1] );
		equals( str.charCodeAt(2), view[2] );
		equals( str.charCodeAt(3), view[3] );
		equals( str.charCodeAt(4), view[4] );
		equals( str.charCodeAt(5), view[5] );
		equals( str.charCodeAt(6), view[6] );
		equals( str.charCodeAt(7), view[7] );
	}

	#end

}
