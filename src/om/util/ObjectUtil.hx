package om.util;

class ObjectUtil {

	#if js

	public static inline function is( a : Dynamic, b : Dynamic ) : Bool {
		return untyped Object.is( a, b );
	}

	#end
}
