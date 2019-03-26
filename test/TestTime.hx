
import om.Time;
import utest.Assert.*;

class TestTime extends utest.Test {

	function test_now() {
		notNull( Time.now() );
	}

	#if js

	function test_delay( async : utest.Async ) {
		var v = false;
		Time.delay( function(){
			isFalse( v );
			v = true;
			isTrue( v );
			async.done();
		}, 1 );
	}

	#end

	#if sys

	function test_startTime() {
		notNull( Time.startTime );
	}

	#end

}
