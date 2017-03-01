package om;

class Time {

	@:keep
	public static inline function stamp() : Float
		return now();

	@:keep
	public static inline function now() : Float {

		#if sys
		return (Sys.time() - startTime) * 1000;

		#elseif nodejs
		return getNanoSeconds() / 1e6;

		#elseif js
		return untyped window.performance.now();

		#else
		return throw new om.error.NotImplemented();

		#end
	}

	#if sys

	public static var startTime(default,null) : Float = Sys.time();

	#elseif js

	public static inline function asap( fn : Void->Void )
		haxe.Timer.delay( fn, 0 );

	public static inline function createNextTickProvider( ms = 0 ) : (Void->Void)->Void
		return haxe.Timer.delay.bind( _, ms );

	#if nodejs

	public static var startTime(default,null) : Float = getNanoSeconds();

	public static inline function getNanoSeconds() : Float {
		var t = js.Node.process.hrtime();
		return t[0] * 1e9 + t[1];
	}

	#end // nodejs

	#end // js

}
