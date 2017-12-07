package om;

#if macro
import haxe.macro.Expr;
#end

class ArrayTools {


	/*
	//See: https://github.com/polygonal/ds/blob/master/src/de/polygonal/ds/tools/NativeArrayTools.hx
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
	public static inline function add<T>( a : Array<T>, v : T ) : Array<T> {
		a.push( v );
		return a;
	}

	/**
		Returns all the items after the first occurrance of `e`.
	*/
	public static inline function after<T>( a : Array<T>, e : T ) : Array<T> {
		return a.slice( a.indexOf( e ) + 1 );
	}

	/**
		Returns true if predicate return true for all items in the array.
	*/
	public static function all<T>( a : Array<T>, predicate : T->Bool ) : Bool {
		for( e in a )
			if( !predicate( e ) )
				return false;
		return true;
	}

	/**
		Returns true if `f()` return true for at least one element in the array.
	*/
	public static function any<T>( a : Array<T>, f : T->Bool ) : Bool {
		for( e in a )
			if( f( e ) )
				return true;
		return false;
	}

	/**
	*/
	public static inline function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		a = a.concat( b );
		return a;
	}

	public static inline function at<T>( a : Array<T>, indexes : Array<Int> ) : Array<T> {
		return indexes.map( function(i) return a[i] );
	}

	/**
		Returns all items before `e`.
	*/
	public static inline function before<T>( a : Array<T>, e : T ) : Array<T> {
		return a.slice( 0, a.indexOf( e ) );
	}

	/**
		Returns `true` if `e` is found in the array.
	*/
	public static function contains<T>( a : Array<T>, e : T, ?f : T->T->Bool ) : Bool {
		if( f == null )
			return a.indexOf( e ) >= 0;
		for( i in 0...a.length )
			if( f( a[i], e ) )
				return true;
		return false;
	}

	/**
		Returns `true` if all elements are found in the array.
	*/
	public static function containsAll<T>( a : Array<T>, elements : Array<T>, ?f : T->T->Bool ) : Bool {
		for( e in elements )
			if( !contains( a, e, f ) )
				return false;
		return true;
	}

	/**
		Returns `true` if any of `elements` are found in the array.
	*/
	public static function containsAny<T>( a : Array<T>, elements : Array<T>, ?f : T->T->Bool ) : Bool {
		for( e in elements )
			if( contains( a, e, f ) )
				return true;
		return false;
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
		Find the element, remove it, return it.
	*/
	public static function extract<T>( a : Array<T>, f : T->Bool ) : T {
    	for( i in 0...a.length )
      		if( f( a[i] ) )
        		return a.splice( i, 1 )[0];
    	return null;
  	}

	#if js
	/**
		Async filter.
	*/
	public static function filter<T>( a : Array<T>, f : T->(Bool->Void)->Void, callback : Array<T>->Void ) {
        var i = 0;
        var r = [];
        function n() {
            f( a[i], y -> {
                if( y ) r.push( a[i] );
                if( ++i == a.length ) callback( r ) else n();
            } );
        }();
    }
	#end

	/**
		Returns the first element that matches function `f`.
	*/
	public static function find<T>( a : Array<T>, f : T->Bool ) : Null<T> {
		for( e in a ) if( f( e) ) return e;
		return null;
	}

	/**
	*/
	public static function findIndex<T>( a : Array<T>, f : T->Bool ) : Int {
		for( i in 0...a.length ) if( f( a[i] ) ) return i;
		return -1;
	}

	/**
	*/
	public static inline function first<T>( a : Array<T> ) : T {
		return a[0];
	}

	/**
	public static function flatten<T>( a : Array<Array<T>> ) : Array<T> {
	*/

	/**
		Returns `true` if the array contains 0 elements.
	*/
	public static inline function isEmpty<T>( a : Array<T> ) : Bool {
		return a == null || a.length == 0;
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
	macro public static function pluck<T,TOut>( a : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>> {
		return macro $e{a}.map( function(_) return ${expr} );
	}

	/**
	*/
	public static inline function random<T>( a : Array<T> ) : T {
		return a[ Math.floor( Math.random() * a.length - 1 ) ];
	}

	/**
		Resizes an array of `T` to an arbitrary length by adding more elements to its end or by removing extra elements.
		Note that the function changes the passed array and doesn't create a copy.
	**/
	//TODO
  	//public static function resize<T>( array : Array<T>, length : Int, fill : T ) {
  	public static function resize( a : Array<Int>, length : Int, fill : Int = 0 ) {
    	while( a.length < length )
      		a.push( fill );
    	a.splice( length, a.length - length );
    	return a;
	}

	//TODO
	public static function resizeFloatArray( a : Array<Float>, length : Int, fill : Float = 0.0) {
    	while( a.length < length )
      		a.push( fill );
    	a.splice( length, a.length - length );
    	return a;
	}

	/**
		Returns reversed array
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
		Tests whether at least one element in the array passes the test implemented by the provided function.
	*/
	#if js
	public static inline function some<T>( a : Array<T>, f : T->Int->Array<T>->Bool ) {
		return untyped a.some( f );
	}
	#end

	/**
	*/
	public static function sorted<T>( a : Array<T>, f : T->T->Int ) : Array<T> {
		var n = a.copy();
    	n.sort( f );
    	return n;
	}

	/**
	//public static inline function split<T:Int>( a : Array<T>, parts : Int ) : Array<T> {
	*/

	/**
		Returns a copy of the array with the new element added to the end.
	*/
	public static inline function with<T>( a : Array<T>, e : T ) : Array<T> {
		return a.concat( [e] );
	}

}
