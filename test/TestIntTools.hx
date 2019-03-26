
import om.IntTools;
import utest.Assert.*;

class TestIntTools extends utest.Test {

	function test_canParse() {
		isFalse( IntTools.canParse("") );
		isFalse( IntTools.canParse("sdf") );
	}

	function test_parse() {
		isNull( IntTools.parse("") );
		equals( 50, IntTools.parse("50") );
		equals( -50, IntTools.parse("-50") );
		equals( 1, IntTools.parse("1") );
		equals( -1, IntTools.parse("-1") );
		equals( 15, IntTools.parse("015") );
		equals( 15, IntTools.parse("15e1") );
		equals( -15, IntTools.parse("-15e1") );
	}

	function test_isEven() {
		isTrue( IntTools.isEven(0) );
		isFalse( IntTools.isEven(1) );
		isFalse( IntTools.isEven(-1) );
		isTrue( IntTools.isEven(2) );
		isTrue( IntTools.isEven(-2) );
		isFalse( IntTools.isEven(3) );
	}
}
