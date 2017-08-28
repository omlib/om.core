package om;

#if js

@:forward(
    onmessage,onerror,
    postMessage,terminate
)
abstract Worker(js.html.Worker) to js.html.Worker {

    public inline function new( scriptURL : String )
        this = new js.html.Worker( scriptURL );

    public inline function post( ?msg : Dynamic, ?transfer : Array<Dynamic> )
        this.postMessage( msg, transfer );

    public static inline function fromScript( script : String ) : Worker
        return new Worker( createInlineURL( script ) );

    public static inline function createInlineURL( code : String ) : String
        return js.html.URL.createObjectURL( new js.html.Blob( [code] ) );

    /**
        Blob URLs are unique and last for the lifetime of your application (e.g. until the document is unloaded).
        If you're creating many Blob URLs, it's a good idea to release references that are no longer needed.
    */
    public static inline function revokeInlineURL( url : String )
        js.html.URL.revokeObjectURL( url );

    /*
    macro public static function fromFile( path : String ) : haxe.macro.Expr {
        var src = sys.io.File.getContent( path );
        return macro null;
    }
    */
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
