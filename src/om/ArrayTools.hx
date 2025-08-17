package om;

#if macro
import haxe.macro.Expr;
#end

private class ArrayKeyValueIterator<T> {
	final array:Array<T>;
	var index:Int = 0;

	public inline function new(array:Array<T>)
		this.array = array;

	public inline function hasNext()
		return index < array.length;

	public inline function next()
		return {key: index, value: array[index++]};
}

class ArrayTools {
	/**
		Push `v` to `a` and return `a`.
	**/
	public static inline function add<T>(a:Array<T>, v:T):Array<T> {
		a.push(v);
		return a;
	}

	/**
		Returns all the items after the first occurrance of `e`.
	**/
	public static inline function after<T>(a:Array<T>, e:T):Array<T> {
		final i = a.indexOf(e);
		return i >= 0 ? a.slice(i + 1) : [];
	}

	/**
		Returns `true` if predicate returns `true` for all items in the array.
	**/
	public static function all<T>(a:Array<T>, predicate:T->Bool):Bool {
		for (e in a)
			if (!predicate(e))
				return false;
		return true;
	}

	/**
		Returns true if `f()` return true for at least one element in the array.
	**/
	public static function any<T>(a:Array<T>, f:T->Bool):Bool {
		for (e in a)
			if (f(e))
				return true;
		return false;
	}

	/**
		Append to array and resturns the result (shortcut for `a = a.concat(b)`)
	**/
	public static inline function append<T>(a:Array<T>, b:Array<T>):Array<T> {
		a = a.concat(b);
		return a;
	}

	/**
	**/
	public static inline function at<T>(a:Array<T>, indexes:Array<Int>):Array<T> {
		return indexes.map(function(i) return a[i]);
	}

	/**
		Returns all items of array `a` before index of item `e`.
	**/
	public static inline function before<T>(a:Array<T>, e:T):Array<T> {
		final i = a.indexOf(e);
		return i >= 0 ? a.slice(0, i) : [];
	}

	/**
		Returns `true` if `e` is found in given array.
	**/
	public static function contains<T>(a:Array<T>, e:T, ?f:T->T->Bool):Bool {
		if (f == null)
			return a.indexOf(e) >= 0;
		for (i in a)
			if (f(i, e))
				return true;
		return false;
	}

	/**
		Returns `true` if all elements are found in the array.
	**/
	public static function containsAll<T>(a:Array<T>, elements:Array<T>, ?f:T->T->Bool):Bool {
		for (e in elements)
			if (!contains(a, e, f))
				return false;
		return true;
	}

	/**
		Returns `true` if any of `elements` are found in the array.
	**/
	public static function containsAny<T>(a:Array<T>, elements:Array<T>, ?f:T->T->Bool):Bool {
		for (e in elements)
			if (contains(a, e, f))
				return true;
		return false;
	}

	/**
		Returns `a[n-end]`
	**/
	public static inline function dropLeft<T>(a:Array<T>, n:Int):Array<T> {
		return (n >= a.length) ? [] : a.slice(n);
	}

	/**
	**/
	public static inline function dropRight<T>(a:Array<T>, n:Int):Array<T> {
		return (n >= a.length) ? [] : a.slice(0, a.length - n);
	}

	/**
		Returns `true` if all items match.
	**/
	public static function equals<T>(a:Array<T>, b:Array<T>, ?f:T->T->Bool):Bool {
		if (a == null || b == null || a.length != b.length)
			return false;
		if (f == null)
			f = (a, b) -> a == b;
		for (i in 0...a.length)
			if (!f(a[i], b[i]))
				return false;
		return true;
	}

	/**
		Find, remove and return the first element that matches function `f`.
	**/
	public static function extract<T>(a:Array<T>, f:T->Bool):Null<T> {
		for (i in 0...a.length)
			if (f(a[i]))
				return a.splice(i, 1)[0];
		return null;
	}

	#if js
	/**
		Async filter.
	 */
	/*
		public static function filter<T>( a : Array<T>, f : T->(Bool->Void)->Void, callback : Array<T>->Void ) {
			var i = 0;
			var r = [];
			function n() {
				f( a[i], function(y) {
					if( y ) r.push( a[i] );
					if( ++i == a.length ) callback( r ) else n();
				} );
			}();
		}
	 */
	#end

	/**
		Returns the first element that matches function `f`.
	**/
	public static function find<T>(a:Array<T>, f:T->Bool):Null<T> {
		for (e in a)
			if (f(e))
				return e;
		return null;
	}

	/**
		Returns the index of the first element which equals to `e`
	**/
	public static function getIndex<T>(a:Array<T>, e:T):Int {
		for (i in 0...a.length)
			if (e == a[i])
				return i;
		return -1;
	}

	/**
		Returns the index of the first element in the array that satisfies the provided testing function.
	**/
	public static function findIndex<T>(a:Array<T>, f:T->Bool):Int {
		// #if js return untyped a.findIndex( f );
		for (i in 0...a.length)
			if (f(a[i]))
				return i;
		return -1;
	}

	/**
	**/
	public static inline function first<T>(a:Array<T>):T
		return a[0];

	/**
		Creates a new array with all sub-array elements concatenated into it recursively up to the specified depth
	**/
	public static function flat<T>(a:Array<Array<T>>, depth = 1):Array<T> {
		var r = [];
		for (s in a)
			r = r.concat(s);
		return r;
	}

	/**
	**/
	// TODO:
	// public static function flatDynamic(a:Array<Dynamic>, depth = 1):Array<Dynamic> {
	//	var r = [];
	//	for (item in a) {
	//		if (depth > 0 && Std.isOfType(item, Array))
	//			r = r.concat(flat(item, depth - 1));
	//		else
	//			r.push(item);
	//	}
	//	return r;
	// }

	/**
		Returns `true` if the array contains 0 elements.
	**/
	public static inline function isEmpty<T>(a:Array<T>):Bool {
		return a == null || a.length == 0;
	}

	/**
	**/
	public static inline function keys<T>(a:Array<T>) {
		return 0...a.length;
	}

	/**
	**/
	public static inline function keyValueIterator<T>(a:Array<T>) {
		return new ArrayKeyValueIterator(a);
	}

	/**
		Returns the last value of given array (`a[a.length - 1]`)
	**/
	public static inline function last<T>(a:Array<T>):T
		return a[a.length - 1];

	/**
	**/
	public static inline function lastIndex<T>(a:Array<T>):Int
		return a.length - 1;

	/**
		Same as `Array.map` but it adds a second argument to the `callback` function with the current index value.
	**/
	public static function mapi<TIn, TOut>(a:Array<TIn>, callback:TIn->Int->TOut):Array<TOut> {
		var r = [];
		for (i in 0...a.length)
			r.push(callback(a[i], i));
		return r;
	}

	/**
	**/
	public static inline function maxValue<T:Int>(a:Array<T>):T {
		var m = a[0];
		for (v in a)
			if (v > m)
				m = v;
		return m;
	}

	/**
	**/
	public static inline function maxValueIndex<T:Int>(a:Array<T>):Int {
		var h = a[0];
		var i = 0;
		for (j in 0...a.length) {
			final v = a[j];
			if (v > h) {
				h = v;
				i = j;
			}
		}
		return i;
	}

	/**
	**/
	macro public static function pluck<T, TOut>(a:ExprOf<Array<T>>, expr:ExprOf<TOut>):ExprOf<Array<TOut>> {
		return macro $e{a}.map(function(_) return ${expr});
	}

	/**
		Returns a random value from `a`.
	**/
	public static inline function random<T>(a:Array<T>):T {
		return a[Math.floor(Math.random() * a.length)];
	}

	/**
		Resizes an array of `T` to an arbitrary length by adding more elements to its end or by removing extra elements.
		Note that the function changes the passed array and doesn't create a copy.
	**/
	public static function resize<T>(a:Array<T>, length:Int, fill:T):Array<T> {
		while (a.length < length)
			a.push(fill);
		if (a.length > length)
			a.splice(length, a.length - length);
		return a;
	}

	// TODO

	/*
		public static function resizeFloatArray( a : Array<Float>, length : Int, fill : Float = 0.0 ) {
			while( a.length < length )
		  		a.push( fill );
			a.splice( length, a.length - length );
			return a;
		}
	 */
	/**
		Returns reversed copy
	**/
	public static inline function reversed<T>(a:Array<T>):Array<T> {
		var b = a.copy();
		b.reverse();
		return b;
	}

	/**
		Transforms like:
		`[[a0,b0],[a1,b1],[a2,b2]]`
		`[[a0,a1,a2],[b0,b1,b2]]`
	**/
	public static function rotate<T>(a:Array<Array<T>>):Array<Array<T>> {
		var r = [];
		for (i in 0...a[0].length) {
			var row = [];
			r.push(row);
			for (j in 0...a.length)
				row.push(a[j][i]);
		}
		return r;
	}

	/**
		Shuffles given array in place and return it.
	**/
	public static function shuffle<T>(a:Array<T>):Array<T> {
		var x:T, j:Int, i = a.length;
		while (i > 0) {
			j = Math.floor(Math.random() * i);
			x = a[i - 1];
			a[i - 1] = a[j];
			a[j] = x;
			i--;
		}
		return a;
	}

	/*
		public static function shuffled<T>( a : Array<T> ) : Array<T> {
			shuffle( a );
			return a;
		}
	 */
	/**
		Tests whether at least one element in the array passes the test implemented by the provided function.
	**/
	public static #if inline #end function some<T>(a:Array<T>, f:T->Int->Array<T>->Bool):Bool {
		#if js
		return untyped a.some(f);
		#else
		for (i in 0...a.length) {
			if (f(a[i], i, a))
				return true;
		}
		return false;
		#end
	}

	/**
		Sorts and returns `a`
	**/
	public static function sorted<T>(a:Array<T>, f:T->T->Int):Array<T> {
		final n = a.copy();
		n.sort(f);
		return n;
	}

	/**
		//public static inline function split<T:Int>( a : Array<T>, parts : Int ) : Array<T> {
	 */
	/**
		Returns a copy of the array with the new element added to the end.
	**/
	public static inline function with<T>(a:Array<T>, e:T):Array<T> {
		return a.concat([e]);
	}
}
