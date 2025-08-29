package om;

#if macro
import haxe.macro.Context;
import om.Console;

using om.FloatTools;

/**
	Macro-only `Console`.
**/
@defines('om_noconsole_macro', 'Remove all calls to om.Console in macro context')
class ConsoleMacro {
	public static var level:Level = Level.debug;

	public static inline function error(a:Dynamic, ...data:Dynamic)
		println(Level.error, a, data);

	public static inline function warn(a:Dynamic, ...data:Dynamic)
		println(Level.warn, a, data);

	public static inline function info(a:Dynamic, ...data:Dynamic)
		println(Level.info, a, data);

	public static inline function debug(a:Dynamic, ...data:Dynamic)
		println(Level.debug, a, data);

	public static inline function log(level:Level, a:Dynamic, ...data:Dynamic)
		println(level, a, data);

	public static inline function group(label:String)
		om.Console.group(label);

	public static inline function groupEnd()
		om.Console.groupEnd();

	public static inline function clear()
		om.Console.clear();

	public static inline function time(label:String)
		om.Console.time(label);

	public static inline function timeEnd(label:String)
		om.Console.timeEnd(label);

	static function println(level:Level, a:Dynamic, data:Array<Dynamic>) {
		if (Context.defined("om_noconsole_macro"))
			return;
		final out = format(level, [a].concat(data)) + "\n";
		switch level {
			case Level.error:
				Sys.stderr().writeString(out);
				Sys.stderr().flush();
			case _:
				Sys.stdout().writeString(out);
				Sys.stdout().flush();
		}
	}

	static function format(level:om.Console.Level, data:Array<Dynamic>):String {
		var metaAnsi = [90, 40];
		final out = new StringBuf();
		// out.add(Console2.ansify(" MACRO ", [47]));
		out.add(Console.groupIndent());
		out.add(Console.ansify(Time.now().precisionString(3) + ' ', metaAnsi));
		out.add(Console.ansify(" " + Console.getLevelInfoString(level) + " ", Console.theme[level]));
		out.add(" ");
		var pos = Context.getPosInfos(Context.currentPos());
		out.add(Console.ansify(pos.file + ":" + pos.min + "-" + pos.max + ": ", metaAnsi));
		out.add(data.join(", "));
		return out.toString();
	}
}
#end
