package om;

#if macro
import haxe.io.Bytes;
import haxe.macro.Compiler;
import haxe.macro.Context;
import om.macro.MacroTools;
#end

class Haxe {

    /*
    macro public static function isDefined( key : String ) : ExprOf<Bool> {
        return macro $v{haxe.macro.Context.defined( key )};
    }

    macro public static function setCompilerDefine( key : String, value : String ) : haxe.macro.Expr {
        haxe.macro.Compiler.define( key, value );
        return macro null;
    }
    */

    macro public static function isDebug() : ExprOf<Bool> {
        return macro #if debug true #else false #end;
    }

    macro public static function getOutput() : ExprOf<String> {
        return macro $v{Compiler.getOutput()};
    }

    macro public static function addResource( name : String, data : Bytes ) {
        Context.addResource( name, data );
        Context.addResource( name, data );
        return macro null;
    }

    macro public static function getClassPath() : ExprOf<Array<String>> {
        return macro $v{Context.getClassPath()};
    }

    macro public static function getDefines() : ExprOf<Array<Array<String>>> {
        var map = Context.getDefines();
        var arr = new Array<Array<String>>();
        for( key in map.keys() ) {
            arr.push( [key,Std.string(map.get(key))] );
        }
        //return macro $v{map};
        return Context.makeExpr( arr, Context.currentPos() );
    }

    macro public static function parseDefine( key : String ) {
        return Context.parse( Context.definedValue( key ), Context.currentPos() );
    }

    macro public static function warn( msg : String ) : ExprOf<Date> {
        Context.warning( msg, Context.currentPos() );
        return macro null;
    }

    macro public static function error( msg : String ) : ExprOf<Date> {
        Context.error( msg, Context.currentPos() );
        return macro null;
    }

    macro public static function fatalError( msg : String ) : ExprOf<Date> {
        Context.error( msg, Context.currentPos() );
        return macro null;
    }

    macro public static function now() : ExprOf<Date> {
        var date = Date.now();
        var year = MacroTools.toExpr( date.getFullYear() );
        var month = MacroTools.toExpr( date.getMonth() );
        var day = MacroTools.toExpr( date.getDate() );
        var hour = MacroTools.toExpr( date.getHours() );
        var min = MacroTools.toExpr( date.getMinutes() );
        var sec = MacroTools.toExpr( date.getSeconds() );
        return macro new Date( $year, $month, $day, $hour, $min, $sec );
    }

    macro public static function date() : ExprOf<Date> {
        var date = Date.now();
        var year = toExpr( date.getFullYear() );
        var month = toExpr( date.getMonth() );
        var day = toExpr( date.getDate() );
        var hours = toExpr( date.getHours() );
        var mins = toExpr( date.getMinutes() );
        var secs = toExpr( date.getSeconds() );
        return macro new Date( $year, $month, $day, $hours, $mins, $secs );
    }

    macro public static function dateString() : ExprOf<String> {
        return toExpr( Date.now().toString() );
    }



    #if macro

    static inline function toExpr( v : Dynamic ) : haxe.macro.Expr {
        return haxe.macro.Context.makeExpr( v, haxe.macro.Context.currentPos() );
    }

    #end

}
