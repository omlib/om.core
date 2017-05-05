package om.util;

class ObjectUtil {

	#if js

	public static inline function is( a : Dynamic, b : Dynamic ) : Bool {
		return untyped Object.is( a, b );
	}

	#end

	public static inline function copy<A,B>( src : A, dst : Dynamic ) {
		for( f in Reflect.fields( src ) ) {
			Reflect.setField( dst, f, Reflect.field( src, f ) );
		}
	}

	/**
		Poor man clone.
	*/
	public static inline function clone<T>( a : T ) : T {
		var obj : Dynamic = {};
		for( f in Reflect.fields( a ) ) {
			Reflect.setField( obj, f, Reflect.field( a, f ) );
		}
		return obj;
	}

}
