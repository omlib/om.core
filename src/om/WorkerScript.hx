package om;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using om.macro.FieldTools;

class Build {

    /*
    static function build() : Array<Field> {
        var fields = Context.getBuildFields();
        return fields;
    }
    */

    static function autoBuild() : Array<Field> {

        var fields = Context.getBuildFields();
        var pos = Context.currentPos();

        if( fields.hasFunField( 'main' ) )
            Context.fatalError( 'Worker scripts cannot have a main method', pos );
        if( fields.hasFunField( '__init__' ) )
            Context.fatalError( 'Class already has __init__ method', pos );
        if( !fields.hasFunField( 'onMessage' ) )
            Context.fatalError( 'Missing onMessage method', pos );

        var onMessage = fields.findField( 'onMessage' );
        onMessage.meta.push( { name: ':keep', pos: pos } );

        var cl = Context.getLocalClass().get();
        var js = 'self.onmessage='+cl.name+'.onMessage';

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
                        { name: 'aMessage', type: macro : Dynamic },
                        { name: 'transferList', type: macro : Array<Dynamic>, opt: true }
                    ],
                    expr: macro untyped __js__('self.postMessage(aMessage,)'),
                    ret: null
                } ),
                meta: [ { name: ':keep', pos: pos } ],
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
    Implement this interface to build a worker script.

    Usage:
        class MyWorkerScript implements om.WorkerScript {
        	static function onMessage( e : js.html.MessageEvent ) {
                trace( e );
                postMessage( 'howdi' );
            }
        }
*/
@:require(js)
//@:build(om.WorkerScript.Build.build())
@:autoBuild(om.WorkerScript.Build.autoBuild())
interface WorkerScript {}

#end
