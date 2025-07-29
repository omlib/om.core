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
		return names().indexOf(name) >= 0;

	public static inline function names():Array<String> {
		return std.haxe.Resource.listNames();
	}

	macro public static function all():ExprOf<Map<String, haxe.io.Bytes>> {
		var map:Array<Expr> = [];
		for (name in Context.getResources().keys()) {
			var k = macro $v{name};
			var v = macro haxe.Resource.getBytes($v{name});
			map.push(macro $k => $v);
		}
		return macro $a{map};
	}

	macro public static function set(name:String, str:String) {
		Context.addResource(name, haxe.io.Bytes.ofString(str));
		return macro null;
	}

	macro public static function embed(path:String, ?name:String) {
		if (name == null)
			name = path;
		Context.addResource(name, sys.io.File.getBytes(path));
		return macro null;
	}
}
