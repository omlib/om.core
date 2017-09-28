package om.macro;

#if macro
import haxe.macro.Context;
import om.macro.MacroTools.*;
#end

using StringTools;

class SourceCode {

	macro public static function injectSourceCode( code : String ) {
		return macro untyped __js__( '$code' );
	}

	//TODO injects a ; at end
	macro public static function injectComment( str : String ) {
		var target = om.macro.MacroTools.getCompilerTarget();
		var comment = getSingleLineComment();
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

	macro public static function getSingleLineComment( ?target : String ) : ExprOf<String> {
		if( target == null ) target = om.macro.MacroTools.getCompilerTarget();
		return macro $v{switch target {
			case 'lua': '--';
			case 'python': '#';
			case _: '//';
		}}
	}

	/*
	macro public static function injectMultilineComment( str : String ) {
		str = '/*\n\t\t$str\n\t* /';
		return macro untyped __js__( '$str' );
	}
	*/

}
