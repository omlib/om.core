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
		startTime = Time.stamp();
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
		var d = 0.0;
		if( running ) {
			var ts = Time.stamp();
			d = (ts - oldTime) / 1000;
			oldTime = ts;
			elapsedTime += d;
		} else if( autoStart ) {
            start();
            return 0;
        }
		return d;
	}

}
