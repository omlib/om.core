import om.StringTools;
import utest.Assert.*;

class TestStringTools extends utest.Test {
	function test_contains() {
		isTrue(StringTools.contains('abc', 'a'));
		isTrue(StringTools.contains('abc', 'b'));
		isTrue(StringTools.contains('abc', 'c'));

		isTrue(StringTools.contains('abc', 'ab'));
		isTrue(StringTools.contains('abc', 'bc'));

		isFalse(StringTools.contains('abc', ' '));
		isFalse(StringTools.contains('abc', 'aa'));
		isFalse(StringTools.contains('abc', 'ac'));

		isTrue(StringTools.containsAny('abc', ['xx', 'xy', 'bc']));
	}

	function test_count() {
		equals(3, StringTools.count('abc', ''));
		equals(3, StringTools.count('a b c', ' '));
		equals(4, StringTools.count('a  b c', ' '));
		equals(6, StringTools.count('a  b c  ', ' '));

		equals(1, StringTools.countLines('abc'));
		equals(2, StringTools.countLines('abc\n123'));
		equals(3, StringTools.countLines('abc\n123
		'));
		equals(3, StringTools.countLines('abc\n123\nxyz'));
		equals(1, StringTools.countLines(StringTools.removeLinebreaks('abc\n123\nxyz')));
	}

	function test_hasUpperCase() {
		isTrue(StringTools.hasUpperCase('ABC'));
		isTrue(StringTools.hasUpperCase('Abc'));
		isTrue(StringTools.hasUpperCase('aBc'));
		isTrue(StringTools.hasUpperCase('abC'));
		isFalse(StringTools.hasUpperCase('abc'));
	}

	function test_fromIntArray() {
		equals("abc", StringTools.fromIntArray([97, 98, 99]));
	}

	function test_repeat() {
		equals('ababab', StringTools.repeat('ab', 3));
		equals('a a a ', StringTools.repeat('a ', 3));
	}

	function test_reverse() {
		equals('abc', StringTools.reverse('cba'));
		equals('abc_123', StringTools.reverse('321_cba'));
		equals('abc  123', StringTools.reverse('321  cba'));
	}

	function test_toArray() {
		equals('a', StringTools.toArray('abc')[0]);
		equals('b', StringTools.toArray('abc')[1]);
		equals('c', StringTools.toArray('abc')[2]);
	}

	function test_toIntArray() {
		var a = StringTools.toIntArray('abc');
		equals(97, a[0]);
		equals(98, a[1]);
		equals(99, a[2]);
	}

	/*
		function test_replace() {
			var str = "aabbcc";
			trace(str,'a','d');
		}
	 */
	function test_parseFloat() {
		equals('1.2345', StringTools.parseFloat(1.2345));
		equals('1', StringTools.parseFloat(1.2345, 0));
		equals('1.2', StringTools.parseFloat(1.2345, 1));
		equals('1.23', StringTools.parseFloat(1.2345, 2));
		equals('1.234', StringTools.parseFloat(1.2345, 3));
		equals('1.2345', StringTools.parseFloat(1.2345, 4));
		equals('1.2345', StringTools.parseFloat(1.2345, 5));
		equals('1.2345', StringTools.parseFloat(1.2345, 6));
		equals('1.2345', StringTools.parseFloat(1.2345, 10));
		// TODO equals( '1.2345', StringTools.parseFloat( 1.2345, -1 ) );

		equals('-1.2345', StringTools.parseFloat(-1.2345));
		equals('-1', StringTools.parseFloat(-1.2345, 0));
		equals('-1.2', StringTools.parseFloat(-1.2345, 1));
		equals('-1.23', StringTools.parseFloat(-1.2345, 2));
		equals('-1.234', StringTools.parseFloat(-1.2345, 3));
		equals('-1.2345', StringTools.parseFloat(-1.2345, 4));
		equals('-1.2345', StringTools.parseFloat(-1.2345, 5));
		equals('-1.2345', StringTools.parseFloat(-1.2345, 6));
		equals('-1.2345', StringTools.parseFloat(-1.2345, 10));
	}
}
