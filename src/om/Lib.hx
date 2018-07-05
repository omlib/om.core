package om;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.ExprTools;
#end

class Lib {

    //#if sys
    //public static function println()
    //#end

    #if macro

    static function build() {

        Context.onGenerate( function(types) {

            /*
            trace(types.length);



            for( type in types ) {
                switch type {
                //case TAbstract():
                //case TEnum(t,p):
                case TInst(t,params):
                    var meta = t.get().meta;
                    if( meta.has( ':inject' ) ) {
                        var injects = meta.extract( ':inject' );
                        for( inject in injects ) {
                            var params = inject.params;
                            for( p in params ){
                                switch p.expr {
                                case EArrayDecl(a):
                                    for( e in a  ) {
                                        switch e.expr {
                                        case EField(e,f):
                                            switch e.expr {
                                            case EField(e,f):
                                                switch e.expr {
                                                case EField(e,f): trace(f);
                                                case _:
                                                    switch e.expr {
                                                    case EConst(c):
                                                        switch c {
                                                        case CIdent(i):
                                                            //trace(i);
                                                        case _:
                                                        }
                                                    case EField(e,f): trace(f);
                                                    case _: trace(e);
                                                    }
                                                }
                                            case _: trace(e);
                                            }
                                        case _: trace(e);
                                        }
                                    }
                                case _:
                                }
                            }
                        }
                    }
                case _:
                }
            }
            */
        });
    }

    #end
}
