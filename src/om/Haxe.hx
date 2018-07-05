package om;

#if macro
import haxe.io.Bytes;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.PositionTools.here;
import om.macro.MacroTools.*;
using StringTools;
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

    macro public static function getTargetLineComment( ?target : String ) : ExprOf<String> {
		if( target == null ) target = om.macro.MacroTools.getCompilerTarget();
		return macro $v{switch target {
			case 'lua': '--';
			case 'python': '#';
			case _: '//';
		}}
	}

    macro public static function injectCode( code : String ) : ExprOf<String> {
        var target = om.macro.MacroTools.getCompilerTarget();
        return switch target {
        case cpp: macro untyped __cpp__( '$code' );
        case cs: macro untyped __cs__( '$code' );
        case js: macro untyped __js__( '$code' );
        case lua: macro untyped __lua__( '$code' );
        case php: macro untyped __php__( '$code' );
        case java: macro untyped __java__( '$code' );
        //case 'python': macro untyped __python__( '$code' );
        default:
            Context.warning( 'injectCode not implemented [$target]', here() );
            macro null;
        }
    }

    //TODO injects a ; at end
    macro public static function injectComment( str : String ) {
        var target = om.macro.MacroTools.getCompilerTarget();
        var comment = getTargetLineComment();
        if( !str.startsWith( 'comment' ) ) str = '$comment $str';
        return switch target {
        case 'cpp':	macro untyped __cpp__( '$str' );
        case 'cs':	macro untyped __cs__( '$str' );
        case 'js':	macro untyped __js__( '$str' );
        case 'lua':	macro untyped __lua__( '$str' );
        case 'php': macro untyped __php__( '$str' );
        case 'java': macro untyped __java__( '$str' );
        //case 'python': macro untyped __python__( '$str' );
        default:
            Context.warning( 'injectComment not implemented', here() );
            macro null;
        }
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
