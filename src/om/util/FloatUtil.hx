package om.util;

class FloatUtil {

    /**
        Returns the comparison value (an integer number) between two `float` values
    */
    public static function compare( a : Float, b : Float ) : Int {
        return a < b ? -1 : (a > b ? 1 : 0);
    }

    /**
        Returns a value between `a` and `b` for any value of `f` between 0 and 1
    */
    public static inline function interpolate( f : Float, a : Float, b : Float ) {
        return (b - a) * f + a;
    }

    /**
        Returns the smaller of values a and b.
    */
    public static inline function min<T:Float>( a : T, b : T ) : T {
        return a < b ? a : b;
    }

    /**
        Returns the greater of values a and b.
    */
    public static inline function max<T:Float>( a : T, b : T ) : T {
        return a > b ? a : b;
    }

    /***/
    public static function nearEquals( a : Float, b : Float, ?tollerance = 1e-9 ) : Bool {
        if( std.Math.isFinite(a) ) {
            #if (php || java)
            if( !Math.isFinite(b))
                return false;
            #end
            return Math.abs(a - b) <= tollerance;
        }
        if( Math.isNaN(a) )
            return Math.isNaN(b);
        if( Math.isNaN(b) )
            return false;
        if( !Math.isFinite(b) )
            return (a > 0) == (b > 0);
        return false; // a is Infinity and b is finite
    }

    /** */
    public static function wrapCircular( v : Float, max : Float ) : Float {
        v = v % max;
        if( v < 0 ) v += max;
        return v;
    }

}
