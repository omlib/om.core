package om.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;

class AbstractEnumTools {

    /**
        Get all values of an @:enum abstract.

        http://code.haxe.org/category/macros/enum-abstract-values.html
    */
    macro public static function getValues( typePath : Expr ) : Expr {
        var type = Context.getType( typePath.toString() );
        return switch type.follow() {
        case TAbstract( _.get()=>ab, _ ) if( ab.meta.has( ":enum" ) ):
            var valueExprs = [];
            for( f in ab.impl.get().statics.get() ) {
                if( f.meta.has( ":enum" ) && f.meta.has( ":impl" ) ) {
                    var fieldName = f.name;
                    valueExprs.push( macro $typePath.$fieldName );
                }
            }
            macro $a{valueExprs};
        default:
            throw new haxe.macro.Error( type.toString() + " should be @:enum abstract", typePath.pos );
        }
    }

}
