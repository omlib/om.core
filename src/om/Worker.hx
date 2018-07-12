package om;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
using StringTools;
using haxe.macro.ExprTools;
#end

#if (js&&!nodejs)

/**
    The Transferable interface represents an object that can be transfered between different execution contexts, like the main thread and Web workers.
    The ArrayBuffer, MessagePort and ImageBitmap types implement this interface.
*/
typedef Transferable  = Dynamic;

/**
    Represents a background task that can be easily created and can send messages back to its creator.
*/
@:forward(onerror,onmessage,postMessage,terminate)
abstract Worker(js.html.Worker) {

    public inline function new( scriptURL : String )
        this = new js.html.Worker( scriptURL );

    /**
        Sends a message — which can consist of any JavaScript object — to the worker's inner scope.

        @param aMessage The object to deliver to the worker; this will be in the data field in the event delivered to the DedicatedWorkerGlobalScope.onmessage handler.
        @param transferList An optional array of Transferable objects to transfer ownership of.
    */
    public function post( message : Dynamic, ?transfer : Array<Transferable> ) {
        this.postMessage( message, transfer );
    }

    /**
    */
    public static inline function createInlineURL( script : String ) : String
        return js.html.URL.createObjectURL( new js.html.Blob( [script] ) );

    /**
    */
    public static inline function fromScript( script : String ) : om.Worker
        return new om.Worker( createInlineURL( script ) );

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

    /*
    public static macro function build( mainClass : ExprOf<Class<om.WorkerScript>>, ?extraArgs : Array<String>, ?compress : Bool = true ) : ExprOf<om.Worker> {

        var pos = Context.currentPos();

        var mainClassName : String = null;
        switch mainClass.expr {
        case EField(e,f):
            switch e.expr {
            case EConst(c):
                switch c {
                case CIdent(i): mainClassName = '$i.$f';
                case _:
                }
            case _:
            }
        case _:
        }
        if( mainClassName == null ) {
            Context.fatalError( 'main worker class not found', pos );
        }


        var tmpFile = 'worker.tmp';
        var args = ['-js',tmpFile,mainClassName,'-cp','src','-lib','om.core','-D','source-header='];
        if( Context.defined( 'debug' ) ) args.push( '-debug' );
        //args.push( '--no-output' );
        //args = args.concat( Context.getClassPath() );

        if( extraArgs != null ) args = args.concat( extraArgs );

        var p = new Process( 'haxe', args );
        var r = switch p.exitCode() {
        case 0: p.stdout.readAll();
        default: p.stderr.readAll();
        }
        p.close();

        if( r.length > 0 ) Sys.println( r.toString() );

        var script = File.getContent( tmpFile );

        FileSystem.deleteFile( tmpFile );

        if( compress != null ) {

        }

        return macro om.Worker.fromScript( $v{script} );
    }
    */

}

#end
