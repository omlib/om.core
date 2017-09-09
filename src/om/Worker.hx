package om;

#if js

/**
    The Transferable interface represents an object that can be transfered between different execution contexts, like the main thread and Web workers.
    The ArrayBuffer, MessagePort and ImageBitmap types implement this interface.
*/
typedef Transferable  = Dynamic;

/**
    Represents a background task that can be easily created and can send messages back to its creator.
*/
@:forward(onmessage,onerror,postMessage,terminate)
abstract Worker(js.html.Worker) to js.html.Worker {

    public inline function new( scriptURL : String )
        this = new js.html.Worker( scriptURL );

    /**
        Sends a message — which can consist of any JavaScript object — to the worker's inner scope.

        @param aMessage The object to deliver to the worker; this will be in the data field in the event delivered to the DedicatedWorkerGlobalScope.onmessage handler.
        @param transferList An optional array of Transferable objects to transfer ownership of.
    */
    public inline function post( ?aMessage : Dynamic, ?transferList : Array<Transferable> )
        this.postMessage( aMessage, transferList );

    /**
    */
    public static inline function fromScript( script : String ) : om.Worker
        return new om.Worker( createInlineURL( script ) );

    /**
    */
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

    /*
    macro public static function fromWorkerScript<T>( cl : ExprOf<Class<T>> ) {
        trace( cl );
        return macro null;
    }
    */
}

#end
