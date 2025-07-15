package om.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#end

/**
	[`Sys`](https://api.haxe.org/Sys.html) api for macro context.
**/
class Sys {
	public static macro function args():ExprOf<Array<String>> {
		return macro $v{std.Sys.args()};
	}

	public static macro function command(cmd:String, ?args:Array<String>):ExprOf<String> {
		std.Sys.command(cmd, args);
		return macro null;
	}

	public static macro function cpuTime():ExprOf<Float> {
		return macro $v{std.Sys.cpuTime()};
	}

	public static macro function environment():ExprOf<Map<String, String>> {
		var env = std.Sys.environment();
		var map:Array<Expr> = [for (k in env.keys()) macro $v{k} => $v{env.get(k)}];
		return macro $a{map};
	}

	public static macro function executablePath():ExprOf<String> {
		return macro $v{std.Sys.executablePath()};
	}

	/*
		public static macro function exit( code : Int ) {
			std.Sys.exit( code );
			return macro null;
		}
	 */
	public static macro function getChar(echo:Bool):ExprOf<Int> {
		return macro $v{std.Sys.getChar(echo)};
	}

	public static macro function getCwd():ExprOf<String> {
		return macro $v{std.Sys.getCwd()};
	}

	public static macro function getEnv(s:String):ExprOf<String> {
		return macro $v{std.Sys.getEnv(s)};
	}

	public static macro function print(v:Dynamic) {
		Sys.print(v);
		return macro null;
	}

	public static macro function println(v:Dynamic) {
		Sys.println(v);
		return macro null;
	}

	public static macro function programPath():ExprOf<String> {
		return macro $v{std.Sys.programPath()};
	}

	public static macro function setCwd(s:String) {
		std.Sys.setCwd(s);
		return macro null;
	}

	public static macro function setTimeLocale(loc:String):ExprOf<Bool> {
		return macro $v{std.Sys.setTimeLocale(loc)};
	}

	public static macro function sleep(seconds:Float) {
		std.Sys.sleep(seconds);
		return macro null;
	}

	// public static macro function stderr() {
	// public static macro function stdin() {
	// public static macro function stdout() {

	public static macro function systemName():ExprOf<String> {
		return macro $v{std.Sys.systemName()};
	}

	public static macro function time():ExprOf<Float> {
		return macro $v{std.Sys.time()};
	}
}
