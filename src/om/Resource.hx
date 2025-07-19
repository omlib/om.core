package om;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

@:forwardStatics
abstract Resource(haxe.Resource) {
	public static inline function get(name:String):String
		return std.haxe.Resource.getString(name);

	public static inline function exists(name:String):Bool
		return list().indexOf(name) >= 0;

	public static inline function list():Array<String> {
		return std.haxe.Resource.listNames();
	}

	macro public static function all():ExprOf<Map<String, haxe.io.Bytes>> {
		var m = Context.getResources();
		return macro $a{
			list().map(f -> {
				var n = f;
				var v = macro $v{m.get(f)};
				return macro $v{n} => $v;
			})
		};
	}

	macro public static function set(name:String, str:String) {
		Context.addResource(name, haxe.io.Bytes.ofString(str));
		return macro null;
	}
	/*
		macro public static function embed( path : String, id : String ) {
			trace( path, id );
			Context.addResource( id, File.getBytes( path ) );
			return macro null;
		}

		macro public static function embedInline( path : String, id : String ) {
			trace( path, id );
			return macro null;
		}
	 */
	/*
		#if php
		@:access(haxe.Resource.getPath)
		public static inline function getPath( name : String ) : String {
			return std.haxe.Resource.getPath( name );
		}
		#end
	 */
}
