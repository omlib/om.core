import om.FloatTools;
import utest.Assert.*;

class TestFloatTools extends utest.Test {
	function test_canParse() {
		isFalse(FloatTools.canParse("sdf"));
	}

	function test_precision() {
		equals(1.0, FloatTools.precision(1.2, 0));
		equals(1.2, FloatTools.precision(1.2, 1));
		equals(1.2, FloatTools.precision(1.2, 2));

		equals(1.0, FloatTools.precision(1.23456789, 0));
		equals(1.2, FloatTools.precision(1.23456789, 1));
		equals(1.23, FloatTools.precision(1.23456789, 2));
		equals(1.235, FloatTools.precision(1.23456789, 3));
		equals(1.2346, FloatTools.precision(1.23456789, 4));
		equals(1.23457, FloatTools.precision(1.23456789, 5));
		equals(1.234568, FloatTools.precision(1.23456789, 6));
		equals(1.2345679, FloatTools.precision(1.23456789, 7));
		equals(1.23456789, FloatTools.precision(1.23456789, 8));
		equals(1.23456789, FloatTools.precision(1.23456789, 9));
		equals(1.23456789, FloatTools.precision(1.23456789, 10));
		equals(1.23456789, FloatTools.precision(1.23456789, 100));
		equals(1.23456789, FloatTools.precision(1.23456789, 10000000));
		equals(1.2345, FloatTools.precision(1.2345, 100));
		equals(1234.6, FloatTools.precision(1234.56789, 1));
		equals(1234.57, FloatTools.precision(1234.56789, 2));
		equals(1234.568, FloatTools.precision(1234.56789, 3));
		equals(1234.56789, FloatTools.precision(1234.56789, 100));
	}

	function test_sign() {
		equals(1, FloatTools.sign(0));
		equals(1, FloatTools.sign(2));
		equals(-1, FloatTools.sign(-2));
	}
}
