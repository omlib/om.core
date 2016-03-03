package om;

class Emitter<T> implements Disposable {

    public var numHandlers(default,null) : Int;

    var map : Map<String,Array<T->Void>>;

    public function new() {
        clear();
    }

    public function clear() : Emitter<T> {
        map = new Map();
        numHandlers = 0;
        return this;
    }

    public function dispose() {
        clear();
    }

    public function on( eventName : String, handler : T->Void, unshift = false ) : Emitter<T> {
        map.exists( eventName ) ? map.get( eventName ).push( handler ) : map.set( eventName, [handler] );
        numHandlers++;
        return this;
    }

    public function preempt( eventName : String, handler : T->Void ) : Emitter<T> {
        if( map.exists( eventName ) ) {
            map.get( eventName ).unshift( handler );
        } else {
            map.set( eventName, [handler] );
        }
        numHandlers++;
        return this;
    }

    public function off( eventName : String, handlerToRemove : T->Void ) : Emitter<T> {
        if( map.exists( eventName ) )
            map.get( eventName ).remove( handlerToRemove );
        return this;
    }

    public function emit( eventName : String, value : T ) : Emitter<T> {
        if( map.exists( eventName ) )
            for( h in map.get( eventName ) )
                h( value );
        return this;
    }
}
