package om;

abstract Time(Float) {

	public inline function new( v : Float ) this = v;

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

	#elseif nodejs

	public static var startTime(default,null) : Float = getNanoSeconds();

	public static inline function getNanoSeconds() : Float {
		var t = js.Node.process.hrtime();
		return t[0] * 1e9 + t[1];
	}

	#end
}
