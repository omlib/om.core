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
        var pos = Context.currentPos();
        return fields;
    }
    */

    static function autoBuild() : Array<Field> {

        var fields = Context.getBuildFields();
        var pos = Context.currentPos();

        var sup = Context.getLocalClass().get().superClass;
        trace( sup );

        if( fields.hasFunField( '__init__' ) ) {
            //TODO inject expr into __init__ method
            Context.fatalError( 'Class already has __init__ method', pos );
        }
        if( fields.hasFunField( 'main' ) ) {
            Context.fatalError( 'Worker scripts cannot have a main method', pos );
        }
        if( !fields.hasFunField( 'onMessage' ) ) {
            Context.fatalError( 'Missing onMessage method', pos );
        }

        var onMessageField = fields.findField( 'onMessage' );
        onMessageField.meta.push( { name: ':keep', pos: pos } );

        var clName = Context.getLocalClass().get().name;
        var script = 'self.onmessage='+clName+'.onMessage;';

        fields.push({
            name: '__init__',
            access: [APublic,AStatic,AInline],
            kind: FFun( { expr: macro untyped __js__($v{script}), args: [], ret: null } ),
            pos: pos
        });

        /*
        fields.push({
            name: 'worker',
            access: [AMacro,APublic,AStatic],
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
        ```haxe
        class MyWorkerScript implements om.WorkerScript {
        	static function onMessage( e : js.html.MessageEvent ) {
                trace(e);
            }
        }
        ```
*/
//@:build(om.WorkerScript.Build.build())
@:autoBuild(om.WorkerScript.Build.autoBuild())
class WorkerScript {

    /*
    macro public static function worker() {
        return macro null;
    }

    static inline function __init__() {
        untyped __js__($v{script})
    }
    */
}

#end
