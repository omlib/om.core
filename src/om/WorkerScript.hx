package om;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using om.macro.FieldTools;

class Build {

    static function autoBuild() : Array<Field> {

        var pos = Context.currentPos();
        var fields = Context.getBuildFields();

        function error( msg : String ) Context.fatalError( msg, pos );

        /*
        if( fields.hasFunField( 'main' ) )
            error( 'worker scripts cannot have main method' );
        if( fields.hasFunField( '__init__' ) )
            error( 'Class already has __init__ method' );
        if( !fields.hasFunField( 'onMessage' ) )
            error( 'missing [onMessage] method' );
        */

        var onMessage = fields.findField( 'onMessage' );
        onMessage.meta.push( { name: ':keep', pos: pos } );

        var cl = Context.getLocalClass().get();
        var clPath = cl.pack.concat( [cl.name] ).join( '_' );
        var js = 'self.onmessage=$clPath.onMessage';

        fields.push({
            name: '__init__',
            access: [APublic,AStatic,AInline],
            kind: FFun( { expr: macro untyped __js__($v{js}), args: [], ret: null } ),
            pos: pos
        });

        if( !fields.hasFunField( 'postMessage' ) ) {
            fields.push({
                name: 'postMessage',
                access: [APublic,AStatic],
                kind: FFun( {
                    args: [
                        { name: 'message', type: macro:Dynamic },
                        { name: 'transfer', type: macro:Array<Dynamic>, opt: true }
                    ],
                    expr: macro untyped __js__('self.postMessage(message,transfer)'),
                    ret: macro:Void
                } ),
                //meta: [ { name: ':keep', pos: pos } ],
                pos: pos
            });
        }

        /*
        fields.push({
            name: 'worker',
            access: [APublic,AStatic],
            kind: FFun( { expr: macro return null, args: [], ret: null } ),
            pos: pos
        });
        */

        return fields;
    }

}

#else

/**
    Implement this interface to build a standalone worker script.

    Usage:

        class MyWorkerScript implements om.WorkerScript {

        	static function onMessage( e : js.html.MessageEvent ) {
                trace( e );
                postMessage( 'howdi' );
            }
        }
*/
@:autoBuild(om.WorkerScript.Build.autoBuild())
//@:build(om.WorkerScript.Build.build())
@:keepSub
interface WorkerScript {}

#end
