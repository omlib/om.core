package om;

class Math {

	/** Max value, unsigned short */
	//public static inline var UINT16_MAX = 0xFFFF;

	/** Min value, signed short (-0x8000) */
	public static inline var INT16_MIN = -32768;

	/** Max value, signed short (0x7FFF) */
	public static inline var INT16_MAX = 32767;

	/***/
	public static inline var INT32_MIN = -2147483648;

	/** Max value, signed integer (0x7FFFFFFF) */
	public static inline var INT32_MAX = 2147483647;

	/** Euler’s number, the base of the natural logarithm. */
	public static inline var E = 2.718281828459045;

	/***/
	public static inline var EPSILON = 1e-10;

	public static inline var EULER = 0.5772156649015329;

	public static inline var GOLDEN_RATIO = 1.6180339887498948482;

	/** Returns the natural logarithm of 2. */
	public static inline var LN2 = 0.6931471805599453;

	/** Returns the natural logarithm of 10. */
	public static inline var LN10 = 2.302585092994046;

	/** Returns the base-2 logarithm of E. */
	public static inline var LOG2E = 1.4426950408889634;

	/** Returns the base-10 logarithm of E. */
	public static inline var LOG10E = 0.4342944819032518;

	/** The mathematical constant that is the ratio of a circle's circumference to its diameter. */
	public static inline var PI = 3.141592653589793;

	public static inline var PI2 = 6.283185307179586477;

	public static inline var HALF_PI = 1.570796326794896619;

	/** The ratio constant of a circle's circumference to radius, equal to 2 * pi */
	public static inline var TAU = 6.283185307179586;

	/**
		The golden ratio.
		Defined as (1 + sqrt(5)) / 2
		Two quantities are in the golden ratio if their ratio is the same as the ratio of their sum to the larger of the two quantities.
	*/
	public static inline var PHI = 1.618033988749895;

	/** Returns the square root of 1/2. */
	public static inline var SQRT1_2 = 0.7071067811865476;

	/** Returns the square root of 2. */
	public static inline var SQRT2 = 1.4142135623730951;

	//public static inline final DIVIDER_KB = 1024;
	//public static inline final DIVIDER_MB = 1048576;

	//public static inline var DEGREES_TO_RADIANS_FACTOR = 0.017453292519943295; // PI/180
	//public static inline var RADIANS_TO_DEGREES_FACTOR = 57.29577951308232; // 180/PI

	public static var NaN(get,never) : Float;
	static inline function get_NaN() return std.Math.NaN;

	public static var POSITIVE_INFINITY(get,never) : Float;
	static inline function get_POSITIVE_INFINITY() return std.Math.POSITIVE_INFINITY;

	public static var NEGATIVE_INFINITY(get,never) : Float;
	static inline function get_NEGATIVE_INFINITY() return std.Math.NEGATIVE_INFINITY;

	public static inline function abs( f : Float ) : Float
		return f < 0 ? -f : f;

	/**
		Returns the angular distance between 2 angles.
	*/
	public static function angleDifference( a : Float, b : Float, ?turn = 360.0 ) {
		var r = (b - a) % turn;
	    if( r < 0 ) r += turn;
	    if( r > turn / 2 ) r -= turn;
	    return r;
	}

	public static inline function acos( f : Float ) : Float
		return std.Math.acos(f);

	public static inline function asin( f : Float ) : Float
		return std.Math.asin(f);

	public static inline function atan( f : Float ) : Float
		return std.Math.atan(f);

	public static inline function atan2( y : Float, x : Float ) : Float
		return std.Math.atan2(y,x);

	public static inline function ceil( f : Float ) : Int
		return std.Math.ceil( f );

	public static function clamp( value : Float, minOrMax1 : Float, minOrMax2 : Float ) : Float {
		var min = Math.min( minOrMax1, minOrMax2 );
		var max = Math.max( minOrMax1, minOrMax2 );
		return value < min ? min : value > max ? max : value;
	}

	public static inline function cos( f : Float ) : Float
		return std.Math.cos(f);

	/**
		Counts the number of digits in `x`, e.g. 1237.34 has 4 digits.
	*/
	public static inline function countDigits( x : Float ) : Int
		return Std.int( (x == 0) ? 1 : (Math.log(x) / Math.log(10)) + 1 );

	public static inline function degToRad( f : Float ) : Float
		return f * PI / 180;
	//public static inline function degToRad( f : Float ) return f * DEGREES_TO_RADIANS_FACTOR;

	public static inline function exp( f : Float ) : Float
		return std.Math.exp(f);

	public static inline function fceil( f : Float ) : Float
		return std.Math.fceil(f);

	public static inline function fround( f : Float ) : Float
		return std.Math.fround(f);

	public static inline function ffloor( f : Float ) : Float
		return std.Math.ffloor(f);

	public static inline function floor( f : Float ) : Int
		return std.Math.floor(f);

	/**
		Round to 4 significant digits, eliminates < 1e-10
	*/
	public static function fmt( v : Float ) : Float {
		var neg;
		if( v < 0 ) {
			neg = -1.0;
			v = -v;
		} else
			neg = 1.0;
		if( isNaN(v) || !isFinite(v) )
			return v;
		var digits = Std.int( 4 - std.Math.log(v) / std.Math.log(10) );
		if( digits < 1 )
			digits = 1;
		else if( digits >= 10 )
			return 0.;
		var exp = pow( 10, digits );
		return ffloor( v * exp + .49999 ) * neg / exp;
	}

	/*
	public static function interpolate( f : Float, min = 0.0, max = 1.0, ?equation : Float->Float ) : Int {
		return if( equation == null ) Math.round( (min + f) * (max - min) );
		else Math.round( min + equation(f) * ( max - min ) );
	}
	*/

	public static inline function interpolate( f : Float, a : Float, b : Float ) : Float
		return (b - a) * f + a;

	public static function interpolateAngle( f : Float, a : Float, b : Float, turn : Float = 360 )
	    return wrapCircular( interpolate( f, a, a + angleDifference( a, b, turn ) ), turn );

	public static inline function invSqrt( f : Float ) : Float
		return 1.0 / sqrt(f);

	public static inline function isFinite( v : Float ) : Bool
		return std.Math.isFinite( v );

	public static inline function isNaN( v : Float ) : Bool
		return std.Math.isNaN( v );

	public static inline function log( v : Float ) : Float
		return std.Math.log( v );

	public static inline function log10( v : Float ) : Float
		return log( v ) / Math.LN10;

	public static inline function max( a : Float, b : Float ) : Float
		return a < b ? b : a;

	public static inline function min( a : Float, b : Float ) : Float
		return a > b ? b : a;

	public static function nearEquals(a : Float, b : Float, ?tollerance = EPSILON ) {
		if( Math.isFinite( a ) ) {
	 		#if (php || java)
	 		if( !Math.isFinite( b ) )
	   			return false;
	 		#end
	 		return Math.abs( a - b ) <= tollerance;
   		}
   		if( Math.isNaN(a) )
	 		return Math.isNaN( b );
   		if( Math.isNaN(b) )
	 		return false;
   		if( !Math.isFinite(b) )
	 		return (a > 0) == (b > 0);
   		return false; // a is Infinity and b is finite
	}

	public static inline function nearZero( v : Float, tollerance = EPSILON ) : Bool
		return abs( v ) <= tollerance;

	public static inline function normalize( v : Float ) : Float
		return clamp( v, 0, 1 );

	public static inline function pow( v : Float, p : Float ) : Float
		return std.Math.pow( v, p );

	public static inline function radToDeg( f : Float ) : Float
		return f * 180 / PI;
	//public static inline function radToDeg( f : Float )	return f * RADIANS_TO_DEGREES_FACTOR;

	public static inline function random( max : Float = 1.0 ) : Float
		return std.Math.random() * max;

	public static inline function round( f : Float ) : Int
		return std.Math.round(f);

	public static function roundTo( f : Float, precision : Int ) : Float {
		var p = Math.pow( 10, precision );
		return Math.fround( f * p ) / p;
	}

	public static inline function sin( f : Float ) : Float
		return std.Math.sin(f);

	public static inline function sqrt( f : Float ) : Float
		return std.Math.sqrt(f);

	public static inline function tan( f : Float ) : Float
		return std.Math.tan(f);

	public static function wrapCircular( v : Float, max : Float ) : Float {
		v = v % max;
		if( v < 0 ) v += max;
		return v;
    }

}
