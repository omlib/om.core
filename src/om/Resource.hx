package om;

@:forwardStatics
abstract Resource(haxe.Resource) {

	public static macro function all() : ExprOf<Map<String,haxe.io.Bytes>> {
		var m = haxe.macro.Context.getResources();
		return macro $a{ list().map( f -> {
			var n = f;
			var v = macro $v{m.get(f)};
			return macro $v{n} => $v;
		}) };
	}

	public static macro function set( name : String, str : String ) {
		haxe.macro.Context.addResource( name, haxe.io.Bytes.ofString( str ) );
		return macro null;
	}

	public static inline function get( name : String ) : String {
		return std.haxe.Resource.getString( name );
	}

	public static inline function exists( name : String ) : Bool {
		return list().indexOf( name ) >= 0;
	}

	public static inline function list() : Array<String> {
		return std.haxe.Resource.listNames();
	}

	public static inline function count() : Int {
		return list().length;
	}

	/*
	#if php
	@:access(haxe.Resource.getPath)
	public static inline function getPath( name : String ) : String {
		return std.haxe.Resource.getPath( name );
	}
	#end
	*/
}
