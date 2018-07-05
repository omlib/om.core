package om;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;

using haxe.macro.ExprTools;
using haxe.macro.TypeTools;
#end

class MacroTools {

    macro public static function getAbstractEnumFields<T>( typePath : Expr ) : ExprOf<Array<T>> {
        var type = Context.getType( typePath.toString() );
        return switch type.follow() {
        case TAbstract(_.get()=>ab,_) if( ab.meta.has( ":enum" ) ):
            var exprs = [];
            for( f in ab.impl.get().statics.get() ) {
                if( f.meta.has( ":enum" ) && f.meta.has( ":impl" ) ) {
                    exprs.push( macro $v{f.name} );
                }
            }
            macro $a{exprs};
        default:
            throw new haxe.macro.Error( type.toString() + " should be @:enum abstract", typePath.pos );
        }
    }

    macro public static function getAbstractEnumValues<T>( typePath : Expr ) : ExprOf<Array<T>> {
        var type = Context.getType( typePath.toString() );
        return switch type.follow() {
        case TAbstract(_.get()=>ab,_) if( ab.meta.has( ":enum" ) ):
            var exprs = [];
            for( f in ab.impl.get().statics.get() ) {
                if( f.meta.has( ":enum" ) && f.meta.has( ":impl" ) ) {
                    var field = f.name;
                    exprs.push( macro $typePath.$field );
                }
            }
            macro $a{exprs};
        default:
            throw new haxe.macro.Error( type.toString() + " should be @:enum abstract", typePath.pos );
        }
    }


        /*
        #if macro

        static function getAbstractEnumFields<T>( typePath : Expr ) : Array<ClassField> {
            var fields = new Array<ClassField>();
            var type = Context.getType( typePath.toString() );
            return switch type.follow() {
            case TAbstract(_.get()=>ab,_) if( ab.meta.has( ":enum" ) ):
                for( f in ab.impl.get().statics.get() ) {
                    if( f.meta.has( ":enum" ) && f.meta.has( ":impl" ) ) {
                        fields.push(f);
                    }
                }
                fields;
            default:
                throw type.toString() + " should be @:enum abstract";
                //throw new haxe.macro.Error( type.toString() + " should be @:enum abstract", typePath.pos );
            }
        }

        #end
        */

}
