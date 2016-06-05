package om;

class Time {

	public static inline function now() : Float {

		#if sys
		return Sys.time() * 1000;

		#elseif nodejs
		return getNanoSeconds() / 1e6;

		#elseif js
		return untyped window.performance.now();

		#else
		return throw new om.error.NotImplemented();

		#end
	}

	#if nodejs

	public static var startTime(default,null) : Float;

	public static inline function getNanoSeconds() : Float {
		var hr = js.Node.process.hrtime();
		return hr[0] * 1e9 + hr[1];
	}

	static inline function __init__() {
		startTime = getNanoSeconds();
	}

	#end

}
