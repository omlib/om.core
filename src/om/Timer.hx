package om;

import om.Time;

class Timer {

	public var running(default,null) = false;
	public var startTime(default,null) : Float;
	public var interval(default,null) : Float;
	public var elapsed(default,null) : Float;

	public var callback : Void->Void;

	public inline function new( interval : Float ) {
		this.interval = interval;
	}

	public function start( delay = 0 ) : Timer {
		startTime = Time.now() + delay;
		if( !running ) list.push( this );
		running = true;
		return this;
	}

	public function onUpdate( callback : Void->Void ) : Timer {
		this.callback = callback;
		return this;
	}

	public function stop() : Timer {
		list.remove( this );
		elapsed = 0;
		running = false;
		return this;
	}

	static var list = new Array<Timer>();

	public static function delay( callback : Void->Void, time : Float ) : Timer {
		var t = new Timer( time );
		return t.onUpdate(function(){
			callback();
			t.stop();
		}).start();
	}

	public static inline function stopAll()
		for( t in list ) t.stop();

	public static inline function step( time : Float ) {
		for( t in list ) {
			t.elapsed = time - t.startTime;
			if( t.elapsed >= t.interval ) {
				if( t.callback != null ) t.callback();
				t.startTime = time;
				t.elapsed = 0;
			}
		}
	}
}
