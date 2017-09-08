package om;

import om.Time;

/**
	Object for keeping track of time.
*/
class Clock {

    public var autoStart(default,null) : Bool;
	public var running(default,null) = false;
	public var startTime(default,null) = 0.0;
	public var elapsedTime(default,null) = 0.0;
	public var oldTime(default,null) = 0.0;

	public function new( autoStart = true ) {
        this.autoStart = autoStart;
	}

	public function start() {
		startTime = Time.now();
		oldTime = startTime;
		elapsedTime = 0;
		running = true;
	}

	public function stop() {
		getElapsedTime();
		running = autoStart = false;
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
		} else if( autoStart ) {
            start();
            return 0;
        }
		return diff;
	}

}
