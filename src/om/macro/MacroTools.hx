package om.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.PositionTools;
import sys.FileSystem;

using haxe.macro.ExprTools;
using haxe.macro.TypeTools;

class MacroTools {

	public static function asTypePath( s : String, ?params ) : TypePath {
		var parts = s.split( '.' );
		var name = parts.pop();
		var sub = null;
		if( parts.length > 0 && parts[parts.length - 1].charCodeAt(0) < 0x5B ) {
			sub = name;
			name = parts.pop();
			if( sub == name ) sub = null;
		}
		return {
			name: name,
			pack: parts,
			params: params == null ? [] : params,
			sub: sub
		};
	}

	public static function createMetaEntry( name : String, ?params : Array<Expr>, ?pos : Position ) : MetadataEntry {
		return { name: name, params: params, pos: position( pos ) };
	}

	public static function extractMetaParam( type : Type, name : String ) {
		return switch type {
		case TInst(t,params): t.get().meta.extract( name )[0].params[0].getValue();
		default: throw 'cannot extract meta data from '+type;
		}
	}

	public static function getClassAncestor( type : ClassType ) : Null<ClassType> {
        var c = type.superClass;
        return (c == null) ? null : c.t.get();
    }

	public static function getCurrentModulePath() : String
		return Context.getPosInfos( (macro null).pos ).file;

	public static function getFileInClassPath( file : String ) : String {
		for( p in Context.getClassPath() ) {
			var path = p + file;
			if( FileSystem.exists( path ) && !FileSystem.isDirectory( path ) )
				return path;
		}
		return null;
	}

	public static function getFullClassName( cls : ClassType ) : String
		return ((cls.pack.length > 0) ? cls.pack.join(".") + "." : "") + cls.name;

	public static function getLocalClass() : ClassType
		return Context.getLocalClass().get();

	public static function getLocalClassName() : String
		return Context.getLocalClass().toString();

	public static function getMainClass() : String {
		var args = std.Sys.args();
		return switch [args.indexOf('-main'), args.indexOf('-x')] {
			case [-1, -1]: null;
			case [v, -1] | [_, v]: args[v+1];
		}
	}

	public static function getModuleDirectory( type : String ) : String
		return getModulePath( type ).split( "/" ).slice( 0, -1 ).join( "/" );

	public static function getModulePath( type : String ) : String {
    	return switch Context.getType( type ) {
			case TInst(t,_): Context.getPosInfos( t.get().pos ).file;
			case _: throw 'invalid type $type';
		};
	}

	public static function isConstant( e : Expr ) : Bool {
		return switch e.expr {
			case EConst(c): true;
			default: false;
		}
	}

	public static function position( ?pos : Position ) : Position
		return (pos == null) ? Context.currentPos() : pos;

	public static function toExpr( v : Dynamic ) : Expr
		return Context.makeExpr( v, Context.currentPos() );

}

#end
