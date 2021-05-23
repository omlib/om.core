package om;

class Time {

	/**
	**/
	public static inline function now() : Float {

		#if kha
		return kha.System.time;

		#elseif sys
		return (Sys.time() - startTime) * 1000;

		#elseif js
		return Om.performance.now();

		#elseif (doc||test)
		return 0.0;

		#else #error

		#end
	}

	#if js

	public static inline function asap( f : Void->Void, ms = 0 )
		delay( f, ms );

	public static inline function delay( f : Void->Void, ms : Int )
		haxe.Timer.delay( f, ms );

	public static inline function createNextTickProvider( ms = 0 ) : (Void->Void)->Void
		return haxe.Timer.delay.bind( _, ms );

	#end

	#if (js&&!nodejs)

	public static function nextAnimationFrame( fn : (time:Float)->Void ) : Int {
		var i : Int = null;
		return i = raf( (t : Float) -> {
			caf( i );
			fn( t );
		});
	}

	/**
		Short for `window.requestAnimationFrame`
	**/
	public static inline function raf( fn : (time:Float)->Void ) : Int
		return js.Browser.window.requestAnimationFrame( fn );

	/**
		Short for `window.cancelAnimationFrame`
	**/
	public static inline function caf( id : Int )
		js.Browser.window.cancelAnimationFrame( id );

	#end

	#if sys

	public static var startTime(default,null) : Float = Sys.time();

	public static inline function createNextTickProvider( ms = 0 ) : (Void->Void)->Void
		return haxe.Timer.delay.bind( _, ms );

	#end

	/* static var timestamps : Map<String,Float>;

	public static function stamp( label : String ) {
		if( timestamps == null ) timestamps = [];
		timestamps.set( label, now() );
	}
	
	public static function elapsed( label : String ) : Float {
		if( timestamps == null ) return null;
		var v = timestamps.get( label );
		timestamps.remove( label );
		return v;
	} */

}
