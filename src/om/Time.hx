package om;

class Time {

	public static inline function now() : Float {

		#if nodejs
		var hr = js.Node.process.hrtime();
		return ( hr[0] * 1e9 + hr[1] ) / 1e6;

		#elseif js
		return untyped window.performance.now();

		#elseif sys
		return Sys.time();

		#end
	}

}
