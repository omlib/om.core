import utest.Assert.*;
import om.Char;

class TestChar extends utest.Test {
	function test_fromInt() {
		var c:Char = 27;
		equals(27, c);
	}

	function test_fromString() {
		var c:Char = "a";
		equals("a".code, c);
		var c:Char = "abc";
		equals("a".code, c);
	}

	function test_prev_next() {
		var c:Char = "b";
		equals("a".code, c.prev());
		equals("b".code, c);
		equals("c".code, c.next());
	}

	function test_isControl() {
		var c:Char = 1;
		isTrue(c.isControl());
		var c:Char = 0x007F;
		isTrue(c.isControl());
		var c:Char = 0x0080;
		isTrue(c.isControl());
		var c:Char = 0x00A0;
		isFalse(c.isControl());
	}

	function test_isUnicode() {
		var c:Char = 1;
		isTrue(c.isUnicode());
		var c:Char = 65533;
		isTrue(c.isUnicode());
		var c:Char = 65534;
		isFalse(c.isUnicode());
	}
}
