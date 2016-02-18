package om;

import om.Time;

class Timer {

	public var running(default,null) = false;
	public var interval(default,null) : Float;
	public var startTime(default,null) : Float;
	public var elapsed(default,null) : Float;

	public var onUpdate : Void->Void;

	public inline function new( interval : Float ) {
		this.interval = interval;
	}

	public function start( delay = 0 ) : Timer {
		startTime = Time.now() + delay;
		if( !running ) active.push( this );
		running = true;
		return this;
	}

	public function update( callback : Void->Void ) : Timer {
		onUpdate = callback;
		return this;
	}

	public function stop() : Timer {
		active.remove( this );
		elapsed = 0;
		running = false;
		return this;
	}

	static var active = new Array<Timer>();

	public static function delay( callback : Void->Void, time : Float ) : Timer {
		var t = new Timer( time );
		return t.update(function(){
			callback();
			t.stop();
		}).start();
	}

	public static inline function stopAll()
		for( t in active ) t.stop();

	public static inline function step( time : Float ) {
		for( t in active ) {
			t.elapsed = time - t.startTime;
			if( t.elapsed >= t.interval ) {
				if( t.onUpdate != null ) t.onUpdate();
				t.startTime = time;
				t.elapsed = 0;
			}
		}
	}

}
