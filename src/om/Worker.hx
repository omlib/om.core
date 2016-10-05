package om;

#if js

import js.Browser.window;

@:forward(
    onmessage,onerror,
    terminate
)
abstract Worker(js.html.Worker) {

    public inline function new( scriptURL : String )
        this = new js.html.Worker( scriptURL );

    public inline function post( ?msg : Dynamic, ?transfer : Array<Dynamic> )
        this.postMessage( msg, transfer );

    public inline function postMessage( ?msg : Dynamic, ?transfer : Array<Dynamic> )
        this.postMessage( msg, transfer );

    public static inline function fromScript( script : String ) : Worker {
        return new Worker( createInlineURL( script ) );
    }

    public static inline function createInlineURL( script : String ) : String {
        return untyped window.URL.createObjectURL( new js.html.Blob( [ script ] ) );
    }

    public static inline function revokeInlineURL( url : String ) {
        untyped window.URL.revokeObjectURL( url );
    }
}

#elseif sys
//TODO

/*
class Worker {

    public var thread(default,null) : Thread;

    public function new( f : Void->Void ) {
        thread = Thread.create( f );
        thread.sendMessage( Thread.current() );
    }

    public function post( msg : Dynamic ) : Worker {
        thread.sendMessage( msg );
        return this;
    }

    public function read<T>( block = true ) : T {
        return Thread.readMessage( block );
    }

    public static inline function currentThread() : Thread {
        return Thread.current();
    }
}
*/

#end
