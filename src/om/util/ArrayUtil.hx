package om.util;

#if macro
import haxe.macro.Expr;
#end

class ArrayUtil {

	/**
	*/
	public static inline function before<T>( arr : Array<T>, e : T ) : Array<T> {
		return arr.slice( 0, arr.indexOf( e ) );
	}

	/**
		Returns all the elements after the first occurrance of `e`.
	*/
	public static inline function after<T>( arr : Array<T>, e : T ) : Array<T> {
    	return arr.slice( arr.indexOf( e ) + 1 );
	}

	/**
		Returns a copy of the array with the new element added to the end.
	*/
	public inline static function with<T>( a : Array<T>, e : T ) : Array<T> {
		return a.concat( [e] );
	}

	/**
	Returns true if predicate return true for all elements in the array.
	*/
	public static function all<T>( arr : Array<T>, predicate : T->Bool ) : Bool {
		for( e in arr )
		if( !predicate( e ) )
		return false;
		return true;
	}

	/**
	Returns true if predicate return true for at least one element in the array.
	*/
	public static function any<T>( arr : Array<T>, predicate : T->Bool ) : Bool {
		for( e in arr )
		if( predicate( e ) )
		return true;
		return false;
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
	*/
	public static function equals<T>( a : Array<T>, b : Array<T>, f : T->T->Bool ) : Bool {
		if( a == null || b == null || a.length != b.length )
			return false;
		for( i in 0...a.length )
			if( !f( a[i], b[i] ) )
				return false;
		return true;
	}

	/**
	Pushes value to array and returns the array.
	*/
	public static inline function add<T>( arr : Array<T>, v : T ) : Array<T> {
		arr.push( v );
		return arr;
	}

	/**
	*/
	public static inline function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		a = a.concat( b );
		return a;
	}

	/**
	*/
	public static inline function first<T>( a : Array<T> ) : T {
		return a[0];
	}

	/**
		Returns the last value of given array.
	*/
	public static inline function last<T>( a : Array<T> ) : T {
		return a[a.length-1];
	}

	/**
	*/
	public static inline function maxValue<T:Int>( a : Array<T> ) : T {
	    var m = a[0];
		for( v in a ) if( v > m ) m = v;
		return m;
	}

	/**
	*/
	public static inline function maxValueIndex<T:Int>( a : Array<T> ) : Int {
	    var h = a[0];
	    var i = 0;
		for( j in 0...a.length ) {
			var v = a[j];
			if( v > h ) {
				h = v;
				i = j;
			}
		}
		return i;
	}

	/**
		Shuffles given array in place.
	*/
	public static function shuffle<T>( a : Array<T> ) : Array<T> {
		var x : T;
		var x : T, j : Int, i = a.length;
		while( i > 0 ) {
			j = Math.floor( Math.random() * i );
			x = a[i-1];
			a[i-1] = a[j];
			a[j] = x;
			i--;
		}
		return a;
	}

	/**
	*/
	public static function sorted<T>( a : Array<T>, f : T->T->Int ) : Array<T> {
		var n = a.copy();
    	n.sort( f );
    	return n;
	}

	/**
	*/
	public static inline function reversed<T:Int>( a : Array<T> ) : Array<T> {
		var b = a.copy();
    	b.reverse();
    	return b;
	}

	/**
	*/
	public static inline function dropLeft<T>( a: Array<T>, n : Int ) : Array<T> {
		return (n >= a.length) ? [] : a.slice( n );
	}

	/**
	*/
	public static inline function dropRight<T>( a: Array<T>, n : Int ) : Array<T> {
		return (n >= a.length) ? [] : a.slice( 0, a.length - n );
	}

	/**
	*/
	//public static inline function split<T:Int>( a : Array<T>, parts : Int ) : Array<T> {


	////////////////////////////////////////////////////////////////////////////

	/**
	*/
	macro public static function pluck<T,TOut>( arr : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>> {
		return macro $e{arr}.map( function(_) return ${expr} );
	}

}
