package om;

import om.Time;

/**
	Object for keeping track of time.
*/
class Clock {

    public var autoStart(default,null) : Bool;
	public var running(default,null) = false;

	public var timeStart(default,null) = 0.0;
	public var timeElapsed(default,null) = 0.0;
	public var timeOld(default,null) = 0.0;

	public function new( autoStart = true ) {
        this.autoStart = autoStart;
	}

	public function start() {
		timeStart = Time.now();
		timeOld = timeStart;
		timeElapsed = 0;
		running = true;
	}

	public function stop() {
		getElapsedTime();
		running = autoStart = false;
	}

	public function getElapsedTime() : Float {
		getDelta();
		return timeElapsed;
	}

	public function getDelta() : Float {
		var d = 0.0;
		if( running ) {
			var ts = Time.now();
			d = (ts - timeOld) / 1000;
			timeOld = ts;
			timeElapsed += d;
		} else if( autoStart ) {
            start();
            return 0;
        }
		return d;
	}

}
