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

    /***/
    public static inline function min<T:Float>( a : T, b : T ) : T {
        return a < b ? a : b;
    }

    /***/
    public static inline function max<T:Float>( a : T, b : T ) : T {
        return a > b ? a : b;
    }

}
