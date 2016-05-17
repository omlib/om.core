package om.util;

#if macro
import haxe.macro.Expr;
#end

class ArrayUtil {

	/**
		Pushes value to array and returns the array.
	*/
	public static inline function add<T>( arr : Array<T>, v : T ) : Array<T> {
		arr.push( v );
		return arr;
	}

	/**
	*/
	public static function any<T>( arr : Array<T>, predicate : T->Bool ) : Bool {
		for( e in arr )
			if( predicate(e) )
				return true;
		return false;
	}

	/**
	*/
	public static inline function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		a = a.concat( b );
		return a;
	}

	/**
	*/
	public static function contains<T>( arr : Array<T>, element : T, ?eq : T->T->Bool ) : Bool {
		if( eq == null )
			return arr.indexOf( element ) >= 0;
    	for( i in 0...arr.length )
        	if( eq( arr[i], element ) )
				return true;
		return false;
	}

	/**
		Returns the last value of given array.
	*/
	public static inline function last<T>( arr : Array<T> ) : T
		return arr[arr.length-1];

	/**
		Shuffles given array in place.
	*/
	public static function shuffle<T>( arr : Array<T> ) : Array<T> {
		var x : T;
		var x : T, j : Int, i = arr.length;
		while( i > 0 ) {
			j = Math.floor( Math.random() * i );
			x = arr[i-1];
			arr[i-1] = arr[j];
			arr[j] = x;
			i--;
		}
		return arr;
	}

	// https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
	//public static function shuffleFisherYates<T>( arr : Array<T> ) : Array<T> {

	/**
	*/
	public static function sorted<T>( arr : Array<T>, f : T->T->Int ) : Array<T> {
		var n = arr.copy();
    	n.sort( f );
    	return n;
	}

	/**
		Returns a copy of the array with the new element added to the end.
	*/
	public inline static function with<T>( arr : Array<T>, e : T ) : Array<T>
		return arr.concat( [e] );

	/**
	*/
	macro public static function pluck<T,TOut>( arr : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>> {
		return macro $e{arr}.map( function(_) return ${expr} );
	}

}
