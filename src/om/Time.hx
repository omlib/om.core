package om;

class Time {

	/**
	*/
	public static inline function now() : Float {

		#if sys
		return (Sys.time() - startTime) * 1000;

		#elseif electron
		return js.Browser.window.performance.now();

		#elseif nodejs
		return getNanoSeconds() / 1e6;

		#elseif js
		return js.Browser.window.performance.now();

		#elseif (doc||test)
		return 0.0;

		#else #error

		#end
	}

	public static inline function stamp() : Float {
		return now();
	}

	public static inline function timestamp() : Float {
		return now();
	}

	#if js

	public static inline function asap( f : Void->Void )
		haxe.Timer.delay( f, 0 );

	public static inline function createNextTickProvider( ms = 0 ) : (Void->Void)->Void
		return haxe.Timer.delay.bind( _, ms );

	#end

	#if nodejs

	public static var startTime(default,null) : Float = getNanoSeconds();

	public static inline function getNanoSeconds() : Float {
		var t = js.Node.process.hrtime();
		return t[0] * 1e9 + t[1];
	}

	#end

	#if sys

	public static var startTime(default,null) : Float = Sys.time();

	public static inline function createNextTickProvider( ms = 0 ) : (Void->Void)->Void
		return haxe.Timer.delay.bind( _, ms );

	#end

}
