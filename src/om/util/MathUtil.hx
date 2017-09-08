package om.util;

using Math;
using Std;
using om.util.MathUtil;

class MathUtil {

	public static inline var EPSILON = 0.000001;

	public static inline var PI = 3.141592653589793;
	public static inline var DEGREES_TO_RADIANS_FACTOR = 0.017453292519943295; //PI/180
	public static inline var RADIANS_TO_DEGREES_FACTOR = 57.29577951308232; //180/PI

	public static inline function degToRad( f : Float ) : Float {
		//return f * DEGREES_TO_RADIANS_FACTOR;
		return f * PI / 180;
	}

	public static inline function radToDeg( f : Float ) : Float {
		//return f * RADIANS_TO_DEGREES_FACTOR;
		return f * 180 / PI;
	}

	/**
		Returns the angular distance between 2 angles.
	**/
	public static function angleDifference( a : Float, b : Float, ?turn = 360.0 ) : Float {
		var r = (b - a) % turn;
		if( r < 0 ) r += turn;
		if( r > turn/2 ) r -= turn;
		return r;
	}

	/**
        Interpolates values in a polar coordinate system looking for the narrowest delta angle.
        It can be either clock-wise or counter-clock-wise.
    **/
    public static inline function interpolateAngle( f : Float, a : Float, b : Float, turn = 360.0 ) : Float {
        return wrapCircularFloat( interpolate( f, a, a + angleDifference( a, b, turn ) ), turn );
    }

	public static function clamp( value : Float, minOrMax1 : Float, minOrMax2 : Float ) : Float {
		var min = Math.min( minOrMax1, minOrMax2 );
		var max = Math.max( minOrMax1, minOrMax2 );
		return value < min ? min : value > max ? max : value;
	}

	public static function interpolate( f : Float, min = 0.0, max = 1.0, ?equation : Float->Float ) : Int {
		return if( equation == null )
			Math.round( (min + f) * (max - min) );
		else
			Math.round( min + equation(f) * ( max - min ) );
	}

    public static function wrapCircularFloat( v : Float, max : Float ) : Float {
        v = v % max;
        if( v < 0 ) v += max;
        return v;
    }

}
