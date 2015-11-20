package om.util;

class ReflectUtil {

	/**
		Copy fields from a to b and return b
	*/
	public static inline function copyFieldsTo<A,B>( a : A, b : B ) : B {
		copyFields( a, b );
		return b;
	}

	/**
		Copy fields from b to a and return a
	*/
	public static inline function copyFieldsFrom<A,B>( a : A, b : B ) : A {
		copyFields( b, a );
		return a;
	}

	static function copyFields<X,Y>( x : X, y : Y ) {
		for( f in Reflect.fields( x ) )
			Reflect.setField( y, f, Reflect.field( x, f ) );
	}

}
