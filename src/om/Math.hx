package om;

class Math {

	/** Max value, unsigned short */
	public static inline var UINT16_MAX = 0xFFFF;

	/**	Min value, signed short */
	public static inline var INT16_MIN = -0x8000;

	/** Max value, signed short */
	public static inline var INT16_MAX = 0x7FFF;

	/** Max value, signed integer */
	public static inline var INT32_MAX = 0x7FFFFFFF;

	/** Euler’s number, the base of the natural logarithm. */
	public static inline var E = 2.718281828459045;

	/***/
	public static inline var EPSILON = 1e-10;

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

	/** The ratio constant of a circle's circumference to radius, equal to 2 * pi */
	public static inline var TAU = 6.283185307179586;

	/**
		The golden ratio.
		Two quantities are in the golden ratio if their ratio is the same as the ratio of their sum to the larger of the two quantities.
		Defined as (1 + sqrt(5)) / 2
	*/
	public static inline var PHI = 1.618033988749895;

	/** Returns the square root of 1/2. */
	public static inline var SQRT1_2 = 0.7071067811865476;

	/** Returns the square root of 2. */
	public static inline var SQRT2 = 1.4142135623730951;

	//public static inline var DEGREES_TO_RADIANS_FACTOR = 0.017453292519943295; // PI/180
	//public static inline var RADIANS_TO_DEGREES_FACTOR = 57.29577951308232; // 180/PI

	public static var NaN(get,never) : Float;
	static inline function get_NaN() return std.Math.NaN;

	public static var POSITIVE_INFINITY(get,never) : Float;
	static inline function get_POSITIVE_INFINITY() return std.Math.POSITIVE_INFINITY;

	public static var NEGATIVE_INFINITY(get,never) : Float;
	static inline function get_NEGATIVE_INFINITY() return std.Math.NEGATIVE_INFINITY;

	public static inline function abs( f : Float )return f < 0 ? -f : f;
	public static inline function acos( f : Float ) return std.Math.acos(f);
	public static inline function asin( f : Float ) return std.Math.asin(f);
	public static inline function atan( f : Float ) return std.Math.atan(f);
	public static inline function atan2( y : Float, x : Float ) return std.Math.atan2(y,x);
	public static inline function ceil( f : Float ) : Float return std.Math.ceil( f );
	public static inline function cos( f : Float ) return std.Math.cos(f);
	public static inline function degToRad( f : Float ) return f * PI / 180;
	//public static inline function degToRad( f : Float ) return f * DEGREES_TO_RADIANS_FACTOR;
	public static inline function exp( f : Float ) return std.Math.exp(f);
	public static inline function fceil( f : Float ) return std.Math.fceil(f);
	public static inline function ffloor( f : Float ) return std.Math.ffloor(f);
	public static inline function floor( f : Float ) return std.Math.floor(f);
	public static inline function invSqrt( f : Float ) return 1.0 / sqrt(f);
	public static inline function isFinite( v : Float ) return std.Math.isFinite( v );
	public static inline function isNaN( v : Float ) return std.Math.isNaN( v );
	public static inline function log( v : Float ) return std.Math.log( v );
	public static inline function log10( v : Float ) return log( v ) / Math.LN10;
	public static inline function max( a : Float, b : Float ) return a < b ? b : a;
	public static inline function min( a : Float, b : Float ) return a > b ? b : a;
	public static inline function pow( v : Float, p : Float ) return std.Math.pow( v, p );
	public static inline function radToDeg( f : Float )	return f * 180 / PI;
	//public static inline function radToDeg( f : Float )	return f * RADIANS_TO_DEGREES_FACTOR;
	public static inline function random( max = 1.0 ) return std.Math.random() * max;
	public static inline function round( f : Float ) return std.Math.round(f);
	public static inline function sin( f : Float ) return std.Math.sin(f);
	public static inline function sqrt( f : Float ) return std.Math.sqrt(f);
	public static inline function tan( f : Float ) return std.Math.tan(f);

	public static function clamp( value : Float, minOrMax1 : Float, minOrMax2 : Float ) : Float {
		var min = Math.min( minOrMax1, minOrMax2 );
		var max = Math.max( minOrMax1, minOrMax2 );
		return value < min ? min : value > max ? max : value;
	}

	public static function interpolate( f : Float, min = 0.0, max = 1.0, ?equation : Float->Float ) : Int {
		return if( equation == null ) Math.round( (min + f) * (max - min) );
		else Math.round( min + equation(f) * ( max - min ) );
	}

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
		var digits = Std.int(4 - std.Math.log(v) / std.Math.log(10));
		if( digits < 1 )
			digits = 1;
		else if( digits >= 10 )
			return 0.;
		var exp = pow( 10, digits );
		return ffloor(v * exp + .49999) * neg / exp;
	}

}
