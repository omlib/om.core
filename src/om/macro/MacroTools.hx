package om.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class MacroTools {

	public static inline function here() : Position {
		return Context.currentPos();
	}

	public static inline function position( ?pos : Position ) : Position {
		return (pos == null) ? Context.currentPos() : pos;
	}

	public static inline function toExpr( v : Dynamic ) : Expr {
		return Context.makeExpr( v, Context.currentPos() );
	}

	public static inline function getLocalClass() {
	    return Context.getLocalClass().get();
	}

	public static inline function getClassName() : String {
	    return Context.getLocalClass().toString();
	}

	public static inline function getFullClassName( cls : ClassType ) : String {
		return ( (cls.pack.length > 0) ? cls.pack.join(".") + "." : "" ) + cls.name;
	}

	public static function getModulePath( type : String) : String {
    	return switch Context.getType( type ) {
      		case TInst(t,_): Context.getPosInfos( t.get().pos ).file;
			case _: throw 'invalid type $type';
		};
	}

	public static function getModuleDirectory( type : String ) : String {
		return getModulePath( type ).split( "/" ).slice( 0, -1 ).join( "/" );
	}

	public static function getFileInClassPath( file : String ) : String {
		for( path in Context.getClassPath() ) {
			var fullpath = path+file;
			if( sys.FileSystem.exists( fullpath ) && !sys.FileSystem.isDirectory( fullpath ) )
				return fullpath;
	    }
	    return null;
	}

	public static function dateToExpr( ?date : Date ) : ExprOf<Date> {
		if( date == null ) date = Date.now();
		var year = toExpr( date.getFullYear() );
		var month = toExpr( date.getMonth() );
		var day = toExpr( date.getDate() );
		var hours = toExpr( date.getHours() );
		var mins = toExpr( date.getMinutes() );
		var secs = toExpr( date.getSeconds() );
		return macro new Date( $year, $month, $day, $hours, $mins, $secs );
	}

}

#end
