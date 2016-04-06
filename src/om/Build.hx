package om;

#if macro
import haxe.io.Bytes;
import haxe.macro.Context;
import haxe.macro.Compiler;
import om.macro.MacroTools;
#end

class Build {

    macro public static function getOutput() : ExprOf<String> {
        return macro $v{Compiler.getOutput()};
    }

    macro public static function addResource( name : String, data : Bytes ) {
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

}
