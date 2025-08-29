package om;

import om.Time;
#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.PositionTools;
#end

using om.FloatTools;

enum abstract Level(Int) to Int {
	/** Highest severity level, for critical errors. */
	var error;

	/** For warnings that indicate potential problems. */
	var warn;

	/** For general informational messages. */
	var info;

	/** Lowest severity level, for detailed debugging information. */
	var debug;

	// var trace;
	@:to public function toString():String
		return switch this {
			case Level.error: "error";
			case Level.warn: "warn";
			case Level.info: "info";
			case Level.debug: "debug";
			case _: "unknown";
		}
}

/**
	A cross-platform console logging utility.

	Provides leveled logging (`error`, `warn`, `info`, `debug`), grouping, and timing functions.
	The output is color-coded and includes timestamps and location info on sys targets.

	All logging calls are macros, which means they are completely removed from the code
	when compiling with the `-D om_noconsole` flag, resulting in zero performance overhead.

	The verbosity can be controlled at runtime by setting the `Console.level` static variable.
**/
@defines('om_noconsole', 'Remove all calls to om.Console')
class Console {
	/**
		The current logging level.
		Only messages with a level less than or equal to this value will be displayed.
		For example, if `level` is `Level.warn`, only `error` and `warn` messages will be shown.
		Defaults to `Level.debug`.
	**/
	public static var level:Level = Level.debug;

	#if sys
	/**
		ANSI color codes for different log levels.
	**/
	public static var theme = [[41], [45], [44], [30, 100]];

	/**
		Toggles ANSI color output. Defaults to `true`.
	**/
	public static var colorMode = true;

	/**
		The number of spaces to use for each indentation level in groups.
		Defaults to `2`.
	**/
	public static var groupIndentation = 2;

	/**
		The string to use for one level of indentation in groups.
		Defaults to `" "`.
	**/
	public static var groupIndentationString = " ";

	static var groupDepth = 0;
	static var timers:Map<String, Float> = new Map<String, Float>();

	/**
		Wraps a string with ANSI escape codes for coloring.
		@param str The string to colorize.
		@param codes An array of ANSI codes.
	**/
	public static function ansify(str:String, codes:Array<Int>):String
		return !colorMode || codes == null || codes.length == 0 ? str : '\x1B[${codes.join(";")}m$str\x1B[0m';

	/**
		Returns the indentation string for the current group depth.
	**/
	public static inline function groupIndent():String
		return om.StringTools.repeat(groupIndentationString, groupIndentation * groupDepth);
	#end

	macro public static function error(args:Array<Expr>)
		return _log(Level.error, args);

	macro public static function warn(args:Array<Expr>)
		return _log(Level.warn, args);

	macro public static function info(args:Array<Expr>)
		return _log(Level.info, args);

	macro public static function debug(args:Array<Expr>)
		return _log(Level.debug, args);

	/**
		Creates a new inline group in the console log, indenting all following output.
		Call `groupEnd()` to exit the group.
		@param label The label for the group.
	**/
	public static inline function group(label:String) {
		#if nodejs
		js.Node.console.group(label);
		#elseif js
		js.Browser.console.group(label);
		#elseif sys
		Sys.println(groupIndent() + label);
		groupDepth++;
		#end
	}

	/**
		Exits the current inline group and decreases the indentation level.
	**/
	public static inline function groupEnd() {
		#if nodejs
		js.Node.console.groupEnd();
		#elseif js
		js.Browser.console.groupEnd();
		#elseif sys
		if (groupDepth > 0)
			groupDepth--;
		#end
	}

	/**
		Starts a timer with the specified label.
		Call `timeEnd()` with the same label to stop the timer and log the elapsed time.
		@param label The label for the timer.
	**/
	public static inline function time(label:String) {
		#if nodejs
		js.Node.console.time(label);
		#elseif js
		js.Browser.console.time(label);
		#elseif sys
		timers.set(label, Time.now());
		#end
	}

	/**
		Stops the timer with the specified label and logs the elapsed time in milliseconds.
		@param label The label of the timer to stop.
	**/
	public static inline function timeEnd(label:String) {
		#if nodejs
		js.Node.console.timeEnd(label);
		#elseif js
		js.Browser.console.timeEnd(label);
		#elseif sys
		if (timers.exists(label)) {
			final start = timers.get(label);
			timers.remove(label);
			final duration = (Time.now() - start) * 1000;
			Sys.println(label + ': ${duration.precisionString(2)}ms');
		} else {
			Sys.println('Timer \'${label}\' does not exist');
		}
		#end
	}

	/**
		Clears the console.
	**/
	public static inline function clear() {
		#if nodejs
		js.Node.console.clear();
		#elseif js
		js.Browser.console.clear();
		#elseif sys
		Sys.print('\033c');
		#end
	}

	#if macro
	static function _log(level:Level, args:Array<Expr>):Expr {
		if (Context.defined('om_noconsole')) {
			return macro null;
		}
		var logExpr:Expr;
		if (Compiler.isSysTarget()) {
			var metaAnsi = [90, 40];
			var timeExpr:Expr = macro om.Console.ansify(om.FloatTools.precisionString(om.Time.now(), 3) + " ", $v{metaAnsi});
			var loc = PositionTools.toLocation(Context.currentPos());
			var inf = loc.file + ":" + loc.range.start.line;
			if (loc.range.start.line != loc.range.end.line)
				inf += '-${loc.range.end.line}';
			inf += ':${loc.range.start.character}-${loc.range.end.character}';
			var infAnsi = ansify(" " + inf + " ", metaAnsi);
			var levelStr = ansify(" " + getLevelInfoString(level) + " ", theme[level]);
			var msg = _buildMessageExpr(args);
			logExpr = macro Sys.println(Console.groupIndent() + $timeExpr + $v{levelStr + infAnsi} + " " + $msg);
		} else {
			final target = om.Compiler.target();
			logExpr = switch target {
				case js:
					var consoleExpr = Context.defined("nodejs") ? macro js.Node.console : macro js.Browser.console;
					switch level {
						case Level.error: macro $consoleExpr.error($a{args});
						case Level.warn: macro $consoleExpr.warn($a{args});
						case Level.info: macro $consoleExpr.info($a{args});
						case Level.debug: macro $consoleExpr.debug($a{args});
						case _: macro $consoleExpr.log($a{args});
					}
				case _:
					macro null;
			};
		}
		if (logExpr == null || logExpr.expr == EConst(CIdent("null"))) {
			return macro null;
		}
		final messageLevel:Int = level;
		return macro if ($v{messageLevel} <= untyped om.Console.level) {
			${logExpr}
		};
	}

	static function _buildMessageExpr(args:Array<Expr>):ExprOf<String> {
		if (args.length == 0)
			return macro "";
		var parts:Array<Expr> = [];
		var currentString = new StringBuf();
		function flush() {
			if (currentString.length > 0) {
				parts.push(macro $v{currentString.toString()});
				currentString = new StringBuf();
			}
		}
		for (i in 0...args.length) {
			if (i > 0)
				currentString.add(', ');
			switch args[i].expr {
				case EConst(CString(s)):
					currentString.add(s);
				case EConst(CInt(i)):
					currentString.add(Std.string(i));
				case EConst(CFloat(f)):
					currentString.add(Std.string(f));
				default:
					flush();
					parts.push(macro Std.string(${args[i]}));
			}
		}
		flush();
		if (parts.length == 0)
			return macro "";
		if (parts.length == 1)
			return parts[0];
		var result = parts[0];
		for (i in 1...parts.length) {
			result = macro $result + ${parts[i]};
		}
		return result;
	}

	public static inline function getLevelInfoString(level:Level):String {
		return level.toString().toUpperCase();
	}
	#end
}

