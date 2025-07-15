package om.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;
#end

/**
	Emulates some methods of sys.io.File for (non-sys targets) at compile time.
**/
class File {
	macro public static function copy(srcPath:String, dstPath:String) {
		sys.io.File.copy(srcPath, dstPath);
		return macro null;
	}

	macro public static function getBytes(path:String):ExprOf<haxe.io.Bytes> {
		return Context.makeExpr(sys.io.File.getBytes(path), Context.currentPos());
	}

	macro public static function getContent(path:String):ExprOf<String> {
		return Context.makeExpr(sys.io.File.getContent(path), Context.currentPos());
	}

	macro public static function saveContent(path:String, content:String) {
		sys.io.File.saveContent(path, content);
		return macro null;
	}
	/*
		macro public static function getJSON<T>( path : String ) : ExprOf<T> {
			//var str = loadFileAsString( path );
			var str = File.getContent( path );
			var data : T = null;
			try data = Json.parse(str) catch(e:Dynamic) {
				var msg = Std.string(e);
				var pos = Std.parseInt( msg.substr( msg.lastIndexOf(' ') ) ) + 1;
				var line = str.substring( 0, pos ).countLines();
				return Context.error( 'Invalid json: $path line:$line pos:$pos', Context.currentPos() );
			}
			return data.toExpr();
		}

		static function loadFileAsString( path : String ) {
			try {
				var p = Context.resolvePath( path );
				Context.registerModuleDependency( Context.getLocalModule(), p );
				return sys.io.File.getContent(p);
			} catch( e : Dynamic ) {
				return Context.error( 'Failed to load file $path: $e', Context.currentPos() );
			}
		}
	 */
}
