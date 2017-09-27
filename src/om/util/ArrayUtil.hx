package om.util;

#if macro
import haxe.macro.Expr;
#end

class ArrayUtil {

	//See: https://github.com/polygonal/ds/blob/master/src/de/polygonal/ds/tools/NativeArrayTools.hx

	/*
	public static inline function alloc<T>( len : Int ) : Array<T> {
		#if js
		return untyped __js__("new Array({0})", len );
		#elseif neko
		return untyped __dollar__amake( len );
		#elseif cs
		return cs.Lib.arrayAlloc( len );
		#elseif java
		return untyped Array.alloc( len );
		#elseif cpp
		var a = new Array<T>();
		cpp.NativeArray.setSize( a, len );
		return a;
		#elseif python
		return python.Syntax.pythonCode( "[{0}]*{1}", null, len );
		#else
		var a = [];
		untyped a.length = len;
		return a;
		#end
	}
	*/

	/**
		Pushes value to array and returns the array.
	*/
	public static inline function add<T>( arr : Array<T>, v : T ) : Array<T> {
		arr.push( v );
		return arr;
	}

	/**
		Returns all the items after the first occurrance of `e`.
	*/
	public static inline function after<T>( arr : Array<T>, e : T ) : Array<T> {
		return arr.slice( arr.indexOf( e ) + 1 );
	}

	/**
		Returns true if predicate return true for all items in the array.
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
	public static inline function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		a = a.concat( b );
		return a;
	}

	/**
		Returns all items before `e`.
	*/
	public static inline function before<T>( arr : Array<T>, e : T ) : Array<T> {
		return arr.slice( 0, arr.indexOf( e ) );
	}

	/**
		Returns `true` if `e` is found in the array.
	*/
	public static function contains<T>( arr : Array<T>, e : T, ?eq : T->T->Bool ) : Bool {
		if( eq == null )
			return arr.indexOf( e ) >= 0;
		for( i in 0...arr.length )
			if( eq( arr[i], e ) )
				return true;
		return false;
	}

	/**
		Returns `true` if all items match.
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
	public static inline function maxValueIndex<T:Float>( a : Array<T> ) : Int {
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
	*/
	macro public static function pluck<T,TOut>( arr : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>> {
		return macro $e{arr}.map( function(_) return ${expr} );
	}

	/**
	*/
	public static inline function random<T>( arr : Array<T> ) : T {
		return arr[ Math.floor( Math.random() * arr.length - 1 ) ];
	}

	/**
		Resizes an array of `T` to an arbitrary length by adding more elements to its end or by removing extra elements.
		Note that the function changes the passed array and doesn't create a copy.
	**/
	//TODO
  	//public static function resize<T>( array : Array<T>, length : Int, fill : T ) {
  	public static function resize( array : Array<Int>, length : Int, fill : Int = 0 ) {
    	while( array.length < length )
      		array.push( fill );
    	array.splice( length, array.length - length );
    	return array;
	}

	//TODO
	public static function resizeFloatArray( array : Array<Float>, length : Int, fill : Float = 0.0) {
    	while( array.length < length )
      		array.push( fill );
    	array.splice( length, array.length - length );
    	return array;
	}

	/**
	*/
	public static inline function reversed<T:Int>( a : Array<T> ) : Array<T> {
		var b = a.copy();
		b.reverse();
		return b;
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
	//public static inline function split<T:Int>( a : Array<T>, parts : Int ) : Array<T> {

	/**
		Returns a copy of the array with the new element added to the end.
	*/
	public inline static function with<T>( a : Array<T>, e : T ) : Array<T> {
		return a.concat( [e] );
	}

}
