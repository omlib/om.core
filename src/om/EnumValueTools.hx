package om;

#if macro
import haxe.macro.Expr;
#end

class EnumValueTools {

    /**
        Extract values from that instance.

        Usage:

            ```
            using om.EnumValueTools;

            var opt = haxe.ds.Option.Some( 10 );
            var val = opt.extract( Some(v) => v );
            trace( val == 10 ); // true
            ```
    */
    public static macro function extract( value : ExprOf<EnumValue>, pattern : Expr ) : Expr {
        switch pattern {
        case macro $a => $b:
            return macro switch ($value) {
                case $a: $b;
                default: throw "no match";
            }
        default:
            throw new Error( "invalid enum value extraction pattern", pattern.pos );
        }
    }

}
