package om;

#if macro
import haxe.io.Bytes;
import haxe.macro.Compiler;
import haxe.macro.Context;
import om.macro.MacroTools.*;
#end

@:enum abstract CompilerTarget(String) from String to String {
    var cpp = 'cpp';
    var cs = 'cs';
    var hl = 'hl';
    var java = 'java';
    var js = 'js';
    var lua = 'lua';
    var neko = 'neko';
    var php = 'php';
    var python = 'python';
    var swf = 'swf';
}

class Haxe {

    macro public static function addResource( name : String, data : Bytes ) {
        Context.addResource( name, data );
        return macro null;
    }

    macro public static function date() : ExprOf<Date> {
        var d = Date.now();
        return macro new Date( $v{d.getFullYear()}, $v{d.getMonth()}, $v{d.getDate()}, $v{d.getHours()}, $v{d.getMinutes()}, $v{d.getSeconds()} );
    }

    macro public static function dateString() : ExprOf<String> {
        return toExpr( Date.now().toString() );
    }

    macro public static  function define( name : String, ?value : String ) {
        Compiler.define( $v{name}, $v{value} );
        return macro null;
    }

    macro public static function defined( key : String ) : ExprOf<Bool> {
        return macro $v{Context.defined( key )};
    }

    macro public static  function definedValue<T>( key : String, ?def : T ) : T {
        return Context.defined( $v{key} ) ? cast Context.definedValue( $v{key} ) : $v{def};
    }

    macro public static function error( msg : String ) : ExprOf<Date> {
        Context.error( msg, here() );
        return macro null;
    }

    macro public static function fatalError( msg : String ) : ExprOf<Date> {
        Context.fatalError( msg, here() );
        return macro null;
    }

    macro public static function getClassPath() : ExprOf<Array<String>> {
        return macro $v{Context.getClassPath()};
    }

    macro public static function getCompilerTarget() : ExprOf<CompilerTarget> {
        var t = om.macro.MacroTools.getCompilerTarget();
        return macro $v{t};
    }

    macro public static function getCwd() : ExprOf<String> {
        return macro $v{Sys.getCwd()};
    }

    macro public static function getDefines() : ExprOf<Array<Array<String>>> {
        var map = Context.getDefines();
        var arr = new Array<Array<String>>();
        for( key in map.keys() ) {
            arr.push( [key,Std.string(map.get(key))] );
        }
        //return macro $v{map};
        return Context.makeExpr( arr, here() );
    }

    macro public static function getOutput() : ExprOf<String> {
        return macro $v{Compiler.getOutput()};
    }

    macro public static function isDebug() : ExprOf<Bool> {
        return macro #if debug true #else false #end;
    }

    macro public static function now() : ExprOf<Date> {
        var d = Date.now();
        return macro new Date( $v{d.getFullYear()}, $v{d.getMonth()}, $v{d.getDate()}, $v{d.getHours()}, $v{d.getMinutes()}, $v{d.getSeconds()} );
    }

    macro public static function parseDefine( key : String ) {
        return Context.parse( Context.definedValue( key ), here() );
    }

    macro public static function println( msg : String ) {
        Sys.println( msg );
        return macro null;
    }

    macro public static function warn( msg : String ) : ExprOf<Date> {
        Context.warning( msg, here() );
        return macro null;
    }

}
