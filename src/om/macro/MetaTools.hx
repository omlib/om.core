package om.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import om.macro.MacroTools.position;

class MacroMetaTools {

	public static inline function createMetaEntry( name : String, ?params : Array<Expr>, ?pos : Position ) : MetadataEntry {
		return {
			name: name,
			params: params,
			pos: position( pos )
		};
	}

	public static function extractParameterValue( type : Type, name : String ) : String {
		switch type {
		case TInst(t,params):
			var meta = t.get().meta;
			var value = ExprTools.getValue( meta.extract( name )[0].params[0] );
			return value;
		default:
			return throw 'not implementd';
		}
		return null;
	}

}

#end
