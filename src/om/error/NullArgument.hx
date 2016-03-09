package om.error;

import haxe.PosInfos;

class NullArgument extends om.Error {

	public function new( message : String, ?pos : PosInfos ) {
		super( message, pos );
	}

	macro public static function throwIfNull<T>( expr : ExprOf<Null<T>> ) {
		var name = switch expr.expr {
			case EMeta( { name:':this' }, { expr: EConst(CIdent(s)) } ): s;
			case EConst(CIdent(s)): s;
	 		case _: haxe.macro.Context.error( "argument must be an identifier", expr.pos );
		}
		return macro if( $e{expr} == null ) throw new om.error.NullArgument( 'argument "$name" cannot be null' );
	}

	//macro public static function throwIfEmpty(expr : haxe.macro.Expr) {
}
