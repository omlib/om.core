package om;

class FloatTools {

    static var pattern_parse = ~/^(\+|-)?(:?\d+(\.\d+)?(e-?\d+)?|nan|NaN|NAN)$/;
    static var pattern_inf = ~/^\+?(inf|Inf|INF)$/;
    static var pattern_neg_inf = ~/^-(inf|Inf|INF)$/;

    public static function canParse( s : String ) : Bool
        return pattern_parse.match(s) || pattern_inf.match(s) || pattern_neg_inf.match(s);

    public static function parse( s : String ) : Float {
        if( s.substring( 0, 1 ) == "+" ) s = s.substring( 1 );
        return if( pattern_inf.match( s ) ) Math.POSITIVE_INFINITY
        else if( pattern_neg_inf.match( s ) ) Math.NEGATIVE_INFINITY
        else Std.parseFloat( s );
    }

}
