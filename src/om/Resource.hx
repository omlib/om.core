package om;

@:forwardStatics
abstract Resource(haxe.Resource) {

	public static inline function get( name : String ) : String {
		return std.haxe.Resource.getString( name );
	}

	public static inline function exists( name : String ) : Bool {
		return list().indexOf( name ) >= 0;
	}

	public static inline function list() : Array<String> {
		return std.haxe.Resource.listNames();
	}

	/*
	#if php
	@:access(haxe.Resource.getPath)
	public static inline function getPath( name : String )  : String {
		return std.haxe.Resource.getPath( name );
	}
	#end
	*/

	/*
	macro public static function addString( name : String, content : String ) {
		haxe.macro.Context.addResource( name, haxe.io.Bytes.ofString( content ) );
		return macro null;
	}

	macro public static function addBytes( name : String, content : haxe.io.Bytes ) {
		haxe.macro.Context.addResource( name, content );
		return macro null;
	}
	*/

}
