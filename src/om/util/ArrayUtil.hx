package om.util;

#if macro
import haxe.macro.Expr;
#end

class ArrayUtil {

	public static function any<T>( arr : Array<T>, predicate : T->Bool ) {
		for( e in arr ) if( predicate(e) ) return true;
		return false;
	}

	public static inline function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		a = a.concat(b);
		return a;
	}

	public static function contains<T>( arr : Array<T>, element : T, ?eq : T->T->Bool ) : Bool {
		if( eq == null )
			return arr.indexOf( element ) >= 0;
    	for( i in 0...arr.length )
        	if( eq( arr[i], element ) )
				return true;
		return false;
	}

	public static inline function last<T>( a : Array<T> ) : T
		return a[a.length-1];

	public static function sorted<T>( array : Array<T>, f : T->T->Int ) : Array<T> {
		var n = array.copy();
    	n.sort( f );
    	return n;
	}

	/**
		Returns a copy of the array with the new element added to the end.
	*/
	public inline static function with<T>( arr : Array<T>, e : T ) : Array<T>
		return arr.concat( [e] );

	macro public static function pluck<T,TOut>( arr : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>> {
		return macro $e{arr}.map( function(_) return ${expr} );
	}

}
