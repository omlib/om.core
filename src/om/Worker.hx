package om;

#if js

@:forward(
    onmessage,onerror,
    //postMessage,
    terminate
)
abstract Worker(js.html.Worker) {

    public inline function new( scriptURL : String )
        this = new js.html.Worker( scriptURL );

    public inline function postMessage( ?message : Dynamic, ?transfer : Array<Dynamic> )
        this.postMessage( message, transfer );

    public inline function post( ?message : Dynamic, ?transfer : Array<Dynamic> )
        this.postMessage( message, transfer );

    public static inline function createInlineURL( script : String ) : String
        return om.util.WorkerUtil.createInlineWorkerURL( script );

    public static inline function revokeInlineURL( url : String )
        om.util.WorkerUtil.revokeInlineWorkerURL( url );

}

#end
