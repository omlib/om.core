package om;

import om.Time.now;

/**
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
		startTime = now();
		oldTime = startTime;
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
			var now = now();
			diff = (now - oldTime) * 0.001;
			oldTime = now;
			elapsedTime += diff;
		}
		return diff;
	}

}
