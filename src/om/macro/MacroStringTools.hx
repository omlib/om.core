package om.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

class MacroStringTools {

    macro public static function repeat( str : String, times : Int ) : ExprOf<String> {
        var buf = new StringBuf();
        for( i in 0...times ) buf.add( str );
        var s = buf.toString();
        return macro $v{s};
    }

}
