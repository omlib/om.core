package om;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
using haxe.macro.ExprTools;
using haxe.macro.Tools;
#end

/**
    @see: https://code.haxe.org/category/macros/enum-abstract-values.html
*/
class AbstractEnumTools {

	/**
		Returns an array of constructor names of a given `@:enum abstract` type.
	*/
	macro public static function getNames( eAbstract : Expr ) : ExprOf<Array<String>> {
		return macro $v{ getFields( eAbstract ).map( e -> return e.name ) };
	}

    /**
        Returns an array of all values of a given `@:enum abstract` type.
    */
	macro public static function getValues<T>( eAbstract : Expr ) : ExprOf<Array<T>> {
		return macro $a{ getFields( eAbstract ).map( f -> {
			var name = f.name;
			return macro $eAbstract.$name;
		}) };
	}

	/**
	*/
	macro public static function count( eAbstract : Expr ) : ExprOf<Int> {
		return macro $v{ getFields( eAbstract ).length }
	}

	/**
	*/
	macro public static function toMap<T>( eAbstract : Expr ) : ExprOf<Map<String,T>> {
		return macro $a{ getFields( eAbstract ).map( f -> {
			var n = f.name;
			var v = macro $eAbstract.$n;
			return macro $v{n} => $v;
		}) };
	}

	#if macro

	static function getFields( eAbstract : Expr ) : Array<ClassField> {
		var type = Context.getType( eAbstract.toString() );
		return switch type.follow() {
		case TAbstract(_.get()=>ab,_) if( ab.meta.has( ":enum" ) ):
			ab.impl.get().statics.get();
		default:
			throw new Error( type.toString() + " should be @:enum abstract", eAbstract.pos );
		}
	}

	#end

}
