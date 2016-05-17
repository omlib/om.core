package om;

class Time {

	#if (sys||nodejs)

	static inline function __init__() {
		#if sys
		startTime = Sys.time();
		#elseif nodejs
		startTime = getNanoSeconds();
		#end
	}

	#end

	public static var startTime(default,null) : Float;

	/*
	#if sys
	public static var startTime(default,null) : Float; //= Sys.time();

	#elseif nodejs
	public static var startTime(default,null) = getNanoSeconds();
	#end
	*/

	//public static var start(default,null) = now();

	public static inline function now() : Float {

		#if sys
		//return Sys.cpuTime();
		//trace(Sys.time()-start);
		//return (Sys.time() - start) * 1000;
		//trace(Sys.time()-startTime);
		return Sys.time() * 1000;

		#elseif nodejs
		return getNanoSeconds() / 1e6;

		#elseif js
		return untyped window.performance.now();

		#end
	}

	#if nodejs

	public static inline function getNanoSeconds() : Float {
		var hr = js.Node.process.hrtime();
		return hr[0] * 1e9 + hr[1];
	}

	#end

}
