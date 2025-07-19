package om;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
#end

enum abstract CompilerTarget(String) to String {
	var cpp;
	// var cs;
	var hl;
	// var hlc = 'hlc';
	// var java;
	var jvm;
	var js;
	// var nodejs;
	var lua;
	var neko;
	var php;
	var python;
	// var swf = 'swf';
}

/**
	Compile time methods.
**/
class Build {
	macro public static function define(name:String, ?value:String) {
		haxe.macro.Compiler.define(name, value);
		return macro null;
	}

	macro public static function defined(key:String):ExprOf<Bool>
		return macro $v{Context.defined(key)};

	macro public static function definedValue(key:String, ?def:String):ExprOf<String>
		return macro $v{Context.defined(key) ? Context.definedValue(key) : def};

	macro public static function warning(msg:String) {
		Context.warning(msg, Context.currentPos());
		return macro null;
	}

	macro public static function error(msg:String) {
		Context.error(msg, Context.currentPos());
		return macro null;
	}

	macro public static function fatalError(msg:String) {
		Context.fatalError(msg, Context.currentPos());
		return macro null;
	}

	macro public static function getClassPath():ExprOf<Array<String>>
		return macro $v{Context.getClassPath()};

	macro public static function getCwd():ExprOf<String>
		return macro $v{Sys.getCwd()};

	macro public static function getOutput():ExprOf<String>
		return macro $v{haxe.macro.Compciler.getOutput()};

	macro public static function now():ExprOf<Date> {
		var d = Date.now();
		return macro new Date($v{d.getFullYear()}, $v{d.getMonth()}, $v{d.getDate()}, $v{d.getHours()}, $v{d.getMinutes()}, $v{d.getSeconds()});
	}

	macro public static function print(msg:String) {
		Sys.print(msg);
		return macro null;
	}

	macro public static function println(msg:String) {
		Sys.println(msg);
		return macro null;
	}

	macro public static function version():ExprOf<String>
		return macro $v{Context.definedValue('haxe_ver')};

	macro public static function isSys():ExprOf<Bool>
		return macro $v{om.Build.isSysTarget()};

	#if macro
	public static function target():CompileraTarget {
		return if (Context.defined("cpp")) cpp; else if (Context.defined("hl")) hl; else if (Context.defined("js")) js; else if (Context.defined("jvm"))
			jvm; else if (Context.defined("lua")) lua; else if (Context.defined("neko")) neko; else if (Context.defined("php")) php; else
			if (Context.defined("python")) python; else null;
	}

	public static function isSysTarget():Bool {
		return switch target() {
			case cpp, hl, java, jvm, lua, neko, php, python: true;
			case js: false;
		}
	}
	#end
}
