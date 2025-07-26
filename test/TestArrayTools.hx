import utest.Assert;
import utest.Assert.*;
import om.ArrayTools;

using om.ArrayTools;

class TestArrayTools extends utest.Test {
	/*
		function test_alloc() {

			var a = ArrayTools.alloc( 0 );
			equals( 0, a.length );
			equals( null, a[0] );

			var a = ArrayTools.alloc( 10 );
			equals( 10, a.length );
			equals( null, a[0] );

		}
	 */
	function test_add() {
		var arr = ArrayTools.add([1, 2, 3], 7);
		equals(4, arr.length);
		equals(1, arr[0]);
		equals(2, arr[1]);
		equals(3, arr[2]);
		equals(7, arr[3]);
	}

	function test_after() {
		var arr = ArrayTools.after([1, 2, 3, 4, 5], 3);
		equals(2, arr.length);
		equals(4, arr[0]);
		equals(5, arr[1]);

		var arr = ArrayTools.after([5, 4, 3, 2, 1], 3);
		equals(2, arr.length);
		equals(2, arr[0]);
		equals(1, arr[1]);

		var arr = ArrayTools.after([-5, 4, -3, 2, 1], 4);
		equals(3, arr.length);
		equals(-3, arr[0]);
		equals(2, arr[1]);
		equals(1, arr[2]);
	}

	function test_all() {
		isTrue(ArrayTools.all([1, 2, 3], function(v) return v > 0));
		isFalse(ArrayTools.all([1, 2, -3], function(v) return v > 0));
	}

	function test_any() {
		isTrue(ArrayTools.any([1, 2, 3], function(v) return v == 2));
		isFalse(ArrayTools.any([1, 2, 3], function(v) return v == 6));
		isTrue(ArrayTools.any([0, 1, 1, 1, 2, 3], function(v) return v == 1));
	}

	function test_append() {
		var arr = ArrayTools.append([1, 2, 3], [666, 11]);
		equals(5, arr.length);
		equals(1, arr[0]);
		equals(2, arr[1]);
		equals(3, arr[2]);
		equals(666, arr[3]);
		equals(11, arr[4]);
	}

	function test_at() {
		var a = [1, 2, 3, 4, 5];
		var r = ArrayTools.at(a, [1, 2, 4]);
		equals(3, r.length);
		equals(2, r[0]);
		equals(3, r[1]);
		equals(5, r[2]);
	}

	function test_before() {
		var a = [1, 2, 3, 4, 5];
		var r = ArrayTools.before(a, 4);
		equals(3, r.length);
		equals(1, r[0]);
		equals(2, r[1]);
		equals(3, r[2]);

		var a = ["a", "zz", "23", "s"];
		var r = ArrayTools.before(a, "zz");
		equals(1, r.length);
		equals("a", r[0]);
	}

	function test_contains() {
		isTrue(ArrayTools.contains([1, 2, 3, 4, 5], 3));
		isTrue(ArrayTools.contains([3, 1, -1, 6, 2], 3));
		isFalse(ArrayTools.contains([1, 2, 3, 4, 5], 6));
		isFalse(ArrayTools.contains([1, 2, 3, 4, 5], 7));
		isFalse(ArrayTools.contains([1, 2, 3, 4, 5], 0));
		isFalse(ArrayTools.contains([1, 2, 3, 4, 5], -1));
		isTrue(ArrayTools.contains([1, 2, 3, 4, 5], 3, (a, e) -> return a == e));
		isFalse(ArrayTools.contains([1, 2, 3, 4, 5], 0, (a, e) -> return a == e));
		isTrue(ArrayTools.contains([1, 2, 3, 4, 5], 3, (a, e) -> return true));
		isFalse(ArrayTools.contains([1, 2, 3, 4, 5], 3, (a, e) -> return false));
	}

	function test_containsAll() {
		isTrue(ArrayTools.containsAll([1, 2, 3, 4, 5], [1, 2, 3, 4, 5]));
		isTrue(ArrayTools.containsAll([1, 2, 3, 4, 5], [2, 3, 4, 5]));
		isFalse(ArrayTools.containsAll([1, 2, 3, 4, 5], [6]));
		isFalse(ArrayTools.containsAll([1, 2, 3, 4, 5], [1, 2, 3, 4, 5, 6]));
		isFalse(ArrayTools.containsAll([1, 2, 3, 4, 5], [0, 1, 2, 3, 4, 5]));
	}

	function test_containsAny() {
		isTrue(ArrayTools.containsAny([1, 2, 3, 4, 5], [1, 2]));
		isTrue(ArrayTools.containsAny([1, 2, 3, 4, 5], [2, 3, 4, 5]));
		isFalse(ArrayTools.containsAny([1, 2, 3, 4, 5], [6]));
	}

	function test_dropLeft() {
		var a = [1, 2, 3, 4, 5];
		var r = ArrayTools.dropLeft(a, 3);
		equals(2, r.length);
		equals(4, r[0]);
		equals(5, r[1]);
	}

	function test_dropRight() {
		var a = [1, 2, 3, 4, 5];
		var r = ArrayTools.dropRight(a, 3);
		equals(2, r.length);
		equals(1, r[0]);
		equals(2, r[1]);

		var a = [1, 2, 3, 4, 5];
		var r = ArrayTools.dropRight(a, 10);
		equals(0, r.length);
	}

	function test_equals() {
		var a = [1, 2, 3, 4, 5];
		var b = [1, 2, 3, 4, 5];
		var c = [1, 2, 3, 4, 1];
		var d = [1, 2, 3, 4];
		isTrue(ArrayTools.equals(a, b, function(x, y) return x == y));
		isFalse(ArrayTools.equals(a, c, function(x, y) return x == y));
		isFalse(ArrayTools.equals(a, c, function(x, y) return x == y));
	}

	function test_extract() {
		var a = [1, 2, 3, 4, 5];
		equals(3, ArrayTools.extract(a, function(e) return e == 3));
		equals(4, a.length);
		equals(1, a[0]);
		equals(2, a[1]);
		equals(4, a[2]);
		equals(5, a[3]);
	}

	#if js
	/*
		function test_filter() {
			var done = Assert.createAsync();
			ArrayTools.filter( [1,2,3,4,5],
				function(e,f) {
					haxe.Timer.delay( function(){
						f( e > 2 );
					}, 1 );
				},
				function(r) {
					equals( 3, r.length );
					equals( 3, r[0] );
					equals( 4, r[1] );
					equals( 5, r[2] );
					done();
				}
			);
		}
	 */
	#end
	function test_find() {
		var a = [1, 2, 3, 4, 5];
		equals(3, ArrayTools.find(a, function(e) return e == 3));
		equals(null, ArrayTools.find(a, function(e) return e == 100));
		equals(5, a.length);
	}

	function test_findIndex() {
		var a = [1, 2, 3, 4, 5];
		equals(2, ArrayTools.findIndex(a, function(e) return e == 3));
		equals(-1, ArrayTools.findIndex(a, function(e) return e == 100));
		equals(5, a.length);
	}

	function test_first() {
		equals(4, ArrayTools.first([4, 2, 8]));
		isNull(ArrayTools.first([]));
	}

	function test_flat() {
		final a = [[0], [1, 2], [3, 4]];
		final f = ArrayTools.flat(a);
		equals(0, f[0]);
	}

	// TODO:
	// function test_flat_dynamic() {
	//	final a:Array<Dynamic> = [0, 1, 2, [3, 4], [5, [6, 7]]];
	//	final f = ArrayTools.flatDynamic(a, 2); // with depth = 2
	//	// equals(0, f[0]);
	//	trace(f); // [0, 1, 2, 3, 4, 5, 6, 7]
	// }

	function test_isEmpty() {
		isTrue(ArrayTools.isEmpty([]));
		isFalse(ArrayTools.isEmpty([0]));
		isFalse(ArrayTools.isEmpty([0, 1]));
	}

	function test_keys() {
		var a = [3, 2, 1];
		var i = 0;
		for (k in ArrayTools.keys(a)) {
			equals(k, i++);
		}
		var a = ["a", "b", "c"];
		i = 0;
		for (k in a.keys()) {
			equals(k, i++);
		}
	}

	function test_last() {
		equals(5, ArrayTools.last([1, 2, 3, 4, 5]));
		equals(null, ArrayTools.last([]));
	}

	// function test_mapi() {

	function test_maxValue() {
		equals(5, ArrayTools.maxValue([1, 2, 3, 4, 5]));
		equals(5, ArrayTools.maxValue([1, 2, 3, 4, 5]));
		equals(5, ArrayTools.maxValue([5, 4, 3, 2, 1]));
		equals(5, ArrayTools.maxValue([4, 3, 5, 2, 1]));
		equals(null, ArrayTools.maxValue([]));
	}

	function test_maxValueIndex() {
		equals(4, ArrayTools.maxValueIndex([1, 2, 3, 4, 5]));
		equals(0, ArrayTools.maxValueIndex([5, 4, 3, 2, 1]));
		equals(2, ArrayTools.maxValueIndex([4, 3, 5, 2, 1]));
	}

	// function test_pluck() {
	// function test_resize() {
	// function test_resizeFloatArray() {

	function test_random() {
		notNull(ArrayTools.random([0, 1, 2]));
		isNull(ArrayTools.random([]));
	}

	function test_reversed() {
		var a = [1, 2, 3, 4, 5];
		var b = ArrayTools.reversed(a);
		equals(5, b.length);
		equals(5, b[0]);
		equals(4, b[1]);
		equals(3, b[2]);
		equals(2, b[3]);
		equals(1, b[4]);
	}

	function test_rotate() {
		var a = [[1, 2], [3, 4], [5, 6]];
		var b = ArrayTools.rotate(a);
		equals(2, b.length);
		equals(1, b[0][0]);
		equals(3, b[0][1]);
		equals(5, b[0][2]);
		equals(2, b[1][0]);
		equals(4, b[1][1]);
		equals(6, b[1][2]);
	}

	function test_shuffle() {
		equals(5, ArrayTools.shuffle([1, 2, 3, 4, 5]).length);
		equals(5, ArrayTools.shuffle([-1, 2, -3, 4, 5]).length);
		equals(0, ArrayTools.shuffle([]).length);
	}

	function test_some() {
		isFalse(ArrayTools.some([2, 5, 8, 1, 4], function(e, i, a) {
			return e > 10;
		}));
		isTrue(ArrayTools.some([12, 5, 8, 1, 4], function(e, i, a) {
			return e > 10;
		}));
		isTrue(ArrayTools.some([12, 5, 8, 1, 4], function(e, i, a) {
			return e % 2 == 0;
		}));
	}

	function test_sorted() {
		var sort = function(a:String, b:String):Int return ((a = a.toLowerCase()) < (b = b.toLowerCase())) ? -1 : (a > b) ? 1 : 0;

		var a = ["ab", "bb", "cb"];
		var s = ArrayTools.sorted(a, sort);
		isTrue(s != a);
		for (i in 0...a.length)
			equals(a[i], s[i]);

		var a = ["cb", "bb", "ab"];
		var s = ArrayTools.sorted(a, sort);
		isTrue(s != a);
	}

	function test_with() {
		var arr = ArrayTools.with([666, 11], 7);
		equals(3, arr.length);
		equals(666, arr[0]);
		equals(11, arr[1]);
		equals(7, arr[2]);
	}
}
