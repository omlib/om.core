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

	public static inline function stamp() : Float
		return now();

	#if js

	public static inline function asap( f : Void->Void, ms = 0 )
		delay( f, ms );

	public static inline function delay( f : Void->Void, ms : Int )
		haxe.Timer.delay( f, ms );

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

	#if (js&&!nodejs)

	public static function nextAnimationFrame( fn : Float->Void ) : Int {
		var id : Int;
		return id = raf( function( time : Float ) {
			caf( id );
			fn( time );
		});
	}

	public static inline function raf( fn : Float->Void ) : Int
		return js.Browser.window.requestAnimationFrame( fn );

	public static inline function caf( id : Int )
		js.Browser.window.cancelAnimationFrame( id );

	#end

	#if sys

	public static var startTime(default,null) : Float = Sys.time();

	public static inline function createNextTickProvider( ms = 0 ) : (Void->Void)->Void
		return haxe.Timer.delay.bind( _, ms );

	#end

}
