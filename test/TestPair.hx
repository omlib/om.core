import utest.Assert.*;
import om.Pair;

class TestPair extends utest.Test {
	function test_pair() {
		var pair = new Pair("disktree", 23);
		equals('disktree', pair.a);
		equals(23, pair.b);
	}

	function test_toArray() {
		var a:Array<Dynamic> = new Pair("disktree", 23);
		equals("disktree", a[0]);
		equals(23, a[1]);
	}

	function test_toBool() {
		var a:Bool = new Pair("disktree", 23);
		isTrue(a);
	}

	function test_isNull() {
		var p:Pair<String, Int> = null;
		isNull(p);
		p = new Pair("disktree", 23);
		notNull(p);
		isTrue(p);
	}
}
