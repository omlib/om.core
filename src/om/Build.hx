package om;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
#end

/**
	Compile time methods.
**/
class Build {

	macro public static function defined(key:String):ExprOf<Bool>
		return macro $v{Context.defined(key)};

	macro public static function definedValue(key:String, ?def:String):ExprOf<String>
		return macro $v{Context.defined(key) ? Context.definedValue(key) : def};

	macro public static function error(msg:String):ExprOf<Date> {
		Context.error(msg, Context.currentPos());
		return macro null;
	}

	macro public static function fatalError(msg:String):ExprOf<Date> {
		Context.fatalError(msg, Context.currentPos());
		return macro null;
	}

	macro public static function getClassPath():ExprOf<Array<String>>
		return macro $v{Context.getClassPath()};

	macro public static function getCwd():ExprOf<String>
		return macro $v{Sys.getCwd()};

	macro public static function getOutput():ExprOf<String>
		return macro $v{Compiler.getOutput()};

	macro public static function now():ExprOf<Date> {
		var d = Date.now();
		return macro new Date($v{d.getFullYear()}, $v{d.getMonth()}, $v{d.getDate()}, $v{d.getHours()}, $v{d.getMinutes()}, $v{d.getSeconds()});
	}

	macro public static function print(msg: String) {
		Sys.print(msg);
		return macro null;
	}

	macro public static function println(msg: String) {
		Sys.println(msg);
		return macro null;
	}

	macro public static function warning(msg: String) {
		Context.warning(msg, Context.currentPos());
		return macro null;
	}
}
