package om.util;

class ArrayUtil {

	public static inline function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		a = a.concat(b);
		return a;
	}

	public static inline function last<T>( a : Array<T> ) : T {
		return a[a.length-1];
	}

	macro public static function pluck<T,TOut>( arr : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>> {
		return macro $e{arr}.map( function(_) return ${expr} );
	}

}
