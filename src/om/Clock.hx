package om;

import om.Time;

/**
	Object for keeping track of time.
*/
class Clock {

	public var running(default,null) = false;
	public var startTime(default,null) : Float;
	public var elapsedTime(default,null) : Float;
	public var oldTime(default,null) : Float;

	public function new() {
		startTime = elapsedTime = oldTime = 0;
	}

	public function start() {
		startTime = Time.now();
		oldTime = startTime;
		elapsedTime = 0;
		running = true;
	}

	public function stop() {
		getElapsedTime();
		running = false;
	}

	public function getElapsedTime() : Float {
		getDelta();
		return elapsedTime;
	}

	public function getDelta() : Float {
		var diff = 0.0;
		if( running ) {
			var now = Time.now();
			diff = (now - oldTime) / 1000;
			oldTime = now;
			elapsedTime += diff;
		}
		return diff;
	}

}
