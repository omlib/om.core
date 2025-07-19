import om.IntTools;
import utest.Assert.*;

class TestIntTools extends utest.Test {
	function test_clamp() {
		equals(4, IntTools.clamp(5, 2, 4));
		equals(2, IntTools.clamp(1, 2, 4));
	}

	function test_compare() {
		equals(0, IntTools.compare(0, 0));
		equals(1, IntTools.compare(1, 0));
		equals(-1, IntTools.compare(0, 1));
		equals(-1, IntTools.compare(-1, 0));
		equals(1, IntTools.compare(0, -1));
		equals(0, IntTools.compare(1, 1));
	}

	function test_isEven() {
		isTrue(IntTools.isEven(0));
		isFalse(IntTools.isEven(1));
		isFalse(IntTools.isEven(-1));
		isTrue(IntTools.isEven(2));
		isTrue(IntTools.isEven(-2));
		isFalse(IntTools.isEven(3));
	}

	function test_isOdd() {
		isFalse(IntTools.isOdd(0));
		isTrue(IntTools.isOdd(1));
		isTrue(IntTools.isOdd(-1));
		isFalse(IntTools.isOdd(2));
		isFalse(IntTools.isOdd(-2));
		isTrue(IntTools.isOdd(3));
	}

	function test_sign() {
		equals(1, IntTools.sign(0));
		equals(1, IntTools.sign(1));
		equals(-1, IntTools.sign(-1));
	}

	function test_canParse() {
		isFalse(IntTools.canParse(""));
		isFalse(IntTools.canParse("sdf"));
	}

	function test_parse() {
		isNull(IntTools.parse(""));
		equals(50, IntTools.parse("50"));
		equals(-50, IntTools.parse("-50"));
		equals(1, IntTools.parse("1"));
		equals(-1, IntTools.parse("-1"));
		equals(15, IntTools.parse("015"));
		equals(15, IntTools.parse("15e1"));
		equals(-15, IntTools.parse("-15e1"));
	}
}
