import om.RegExp;
import utest.Assert.*;

class TestRegExp extends utest.Test {
	function test_construct() {
		var e = new RegExp("(haxe)");
		isTrue(e.match("haxe"));
		equals("haxe", e.matched(1));

		var e:RegExp = "(haxe)";
		isTrue(e.match("haxe"));
		equals("haxe", e.matched(1));
	}
}
