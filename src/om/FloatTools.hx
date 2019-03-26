package om;

class FloatTools {

    static var pattern_parse = ~/^(\+|-)?(:?\d+(\.\d+)?(e-?\d+)?|nan|NaN|NAN)$/;
    static var pattern_inf = ~/^\+?(inf|Inf|INF)$/;
    static var pattern_neg_inf = ~/^-(inf|Inf|INF)$/;

    public static function canParse( s : String ) : Bool {
        return pattern_parse.match(s) || pattern_inf.match(s) || pattern_neg_inf.match(s);
	}

    public static function parse( s : String ) : Float {
        if( s.substring( 0, 1 ) == "+" ) s = s.substring( 1 );
        return if( pattern_inf.match( s ) ) Math.POSITIVE_INFINITY
        else if( pattern_neg_inf.match( s ) ) Math.NEGATIVE_INFINITY
        else Std.parseFloat( s );
    }

	/**
		Returns `-1` if `value` is a negative number, `1` otherwise.
	*/
	public static inline function sign<T:Float>( v : T ) : Int {
		return v < 0 ? -1 : 1;
	}

    #if js


    /**
        //TODO https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toPrecision
        @param v
        @param precision  Number of significant digits
    */
    /*
	public static inline function precision( v : Float, precision : Int ) : Float {
        return untyped __js__( "Number.parseFloat({0}).toPrecision({1})", v, precision );
	}
    */

    #end

    //TODO https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/toFixed

    public static function precision( v : Float, precision : Int ) : Float {
        //TODO !js test fails
        //v *= Math.pow( 10, precision );
        //precision += 1;
        return Math.round( v * Math.pow( 10, precision ) ) / Math.pow( 10, precision );
    }

	public static inline function nearEqualAngles( a : Float, b : Float, ?turn = 360.0, ?tollerance = Math.EPSILON ) {
		return Math.abs( angleDifference( a, b, turn ) ) <= tollerance;
	}

	public static function angleDifference(a : Float, b : Float, ?turn : Float = 360.0) {
    var r = (b - a) % turn;
    if(r < 0)
      r += turn;
    if(r > turn / 2)
      r -= turn;
    return r;
  }

}
