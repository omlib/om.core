
import utest.Assert.*;

class TestClock extends utest.Test {

	function test_construct() {

		var clock = new om.Clock();

		isTrue( clock.autoStart );
		isFalse( clock.running );
		equals( 0, clock.timeStart );
		equals( 0, clock.timeElapsed );
		equals( 0, clock.timeOld );
	}

	function test_run() {

		var clock = new om.Clock();

	//	trace(clock.startTime,clock.oldTime);
	//	//trace(clock.timeStart >= 0.0);
		//trace(clock.oldTime >= 0.0);

		isFalse( clock.running );

		clock.start();

		isTrue( clock.running );
		isTrue( clock.timeElapsed >= 0.0 );
		isTrue( clock.timeOld >= 0.0 );
		isTrue( clock.timeStart >= 0.0 );

		clock.stop();

		isFalse( clock.running );
	}

}
