package om;

#if js

typedef Console =
	#if nodejs
		js.node.console.Console;
	#elseif js
		js.html.Console;
	#end

#elseif sys
	#error

/*
//TODO
class Console {

	public var noColors = false;

	public function new() {}

	public inline function log( data : Dynamic ) {
		Sys.println( data );
	}
}
*/

#end
