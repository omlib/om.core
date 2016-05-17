package om;

class Signal<T> implements om.Disposable {

	public var stopped(default,null) = false;

	public var numHandlers(get,never) : Int;
	inline function get_numHandlers() : Int return handlers.length;

	var handlers : Array<T->Void>;

	public inline function new() {
		handlers = [];
	}

	public inline function iterator() : Iterator<T->Void> {
		return handlers.iterator();
	}

	public function bind( h : T->Void ) : Signal<T> {
		handlers.push( h );
		return this;
	}

	public function once( h : T->Void ) : Signal<T> {
		var _h = null;
		_h = function(v:T) {
			remove( _h );
			h( v );
		};
		bind( _h );
		return this;
	}

	public function remove( h : T->Void ) : Bool {
		for( i in 0...handlers.length ) {
			if( Reflect.compareMethods( handlers[i], h ) ) {
				handlers.splice( i, 1)[0];
				return true;
			}
		}
		return false;
	}

	public function has( ?h : T->Void ) : Bool {
		if( h == null )
			return handlers.length > 0;
		for( _h in handlers )
			if( _h == h )
				return true;
		return false;
	}

	public function dispatch( e : T = null ) : Signal<T> {
		var list = handlers.copy();
		for( h in list ) {
			if( stopped ) {
				stopped = false;
				break;
			}
			h( e );
		}
		return this;
	}

	/*TODO
	public function dispatchAndAutomate( e : T ) {
		dispatch(e);
		handlers = [];
		add = function(h : T -> Void)
		{
			h(e);
			return h;
		};
	}
	*/

	public inline function stop() : Signal<T> {
		stopped = true;
		return this;
	}

	public inline function clear() : Signal<T> {
		dispose();
		return this;
	}

	public inline function dispose() {
		stop();
		handlers = [];
	}
}
