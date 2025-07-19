import om.Math;
import utest.Assert.*;

class TestMath extends utest.Test {
	function test_constants() {
		equals(3.141592653589793, Math.PI);
		equals(Math.PI * 2, Math.TAU);

		equals(-32768, Math.INT16_MIN);
		equals(-0x8000, Math.INT16_MIN);

		equals(32767, Math.INT16_MAX);
		equals(0x7FFF, Math.INT16_MAX);

		equals(-2147483648, Math.INT32_MIN);
		equals(2147483647, Math.INT32_MAX);
	}

	function test_abs() {
		equals(1.0, Math.abs(1.0));
		equals(1.0, Math.abs(-1.0));
	}

	function test_rad() {
		equals(Math.PI, Math.degToRad(180));
		equals(180, Math.radToDeg(Math.PI));

		// var ran = Math.random() * 1.0;
		// equals( ran, Math.radToDeg( Math.degToRad( ran ) ) );
	}
}
