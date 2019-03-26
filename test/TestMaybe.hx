
import om.Maybe;
import utest.Assert.*;

class TestMaybe extends utest.Test {

	function test_exists() {

		var val : Maybe<Int> = null;
		isNull( val );
		isFalse( val.exists() );

		val = 23;
		notNull( val );
		isTrue( val.exists() );

		var val : Maybe<Int> = 23;
		notNull( val );
		isTrue( val.exists() );
		equals( 23, val.or( 23 ) );
	}

	function test_sure() {
		var val : Maybe<Int> = null;
		raises( function() val.sure(), String );
	}

	function test_or() {
		var val : Maybe<Int> = null;
		equals( 23, val.or( 23 ) );
	}

	//TODO

	/*
	function test_may() {
	}

	function test_map() {
	}

	function test_mapDefault() {
	}
	*/

}
