package om.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;
#end

/**
    https://code.haxe.org/category/macros/enum-abstract-values.html
*/
class AbstractEnumTools {

    /**
        The following macro function returns an array of all possible values of a given `@:enum abstract` type.
    */
    public static macro function getValues( typePath : Expr ) : Expr {
        var type = Context.getType( typePath.toString() );
        switch type.follow() {
        case TAbstract(_.get()=>ab,_) if( ab.meta.has( ":enum" ) ):
            var valueExprs = [];
            for( f in ab.impl.get().statics.get() ) {
                if( f.meta.has( ":enum" ) && f.meta.has( ":impl" ) ) {
                    var fieldName = f.name;
                    valueExprs.push( macro $typePath.$fieldName );
                }
            }
            return macro $a{valueExprs};
        default:
            // The given type is not an abstract, or doesn't have @:enum metadata, show a nice error message.
            throw new Error( type.toString() + " should be @:enum abstract", typePath.pos );
        }
    }

}
