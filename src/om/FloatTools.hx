package om;

using StringTools;

class FloatTools {
	/**
		Constant value employed to see if two `Float` values are very close.
	**/
	public static inline var EPSILON:Float = 1e-9;

	public static var pattern_parse = ~/^(\+|-)?(:?\d+(\.\d+)?(e-?\d+)?|nan|NaN|NAN)$/;
	public static var pattern_inf = ~/^\+?(inf|Inf|INF)$/;
	public static var pattern_neg_inf = ~/^-(inf|Inf|INF)$/;

	/**
		Returns the shortest angular difference between two angles in the range (-turn/2, +turn/2].
		Default turn is 360 (degrees).
	**/
	public static function angleDifference(a:Float, b:Float, ?turn:Float = 360.0) {
		var r = (b - a) % turn;
		if (r < 0)
			r += turn;
		if (r > turn / 2)
			r -= turn;
		return r;
	}

	/**
		Returns `true` if a string value can be safely converted to`Float`.
	**/
	public static inline function canParse(s:String):Bool
		return pattern_parse.match(s) || pattern_inf.match(s) || pattern_neg_inf.match(s);

	/**
		Rounds a number up to the specified number of decimals.
	**/
	public static function ceilTo(f:Float, decimals:Int):Float {
		final p = Math.pow(10, decimals);
		return Math.fceil(f * p) / p;
	}

	/**
		Restricts a value within the specified range.
	**/
	public static inline function clamp(v:Float, min:Float, max:Float):Float
		return v < min ? min : (v > max ? max : v);

	/**
		Returns the comparison value (int) between two `float` values.
	**/
	public static inline function compare(a:Float, b:Float):Int
		return a < b ? -1 : (a > b ? 1 : 0);

	/**
		`Returns a value between `a` and `b` for any value of `f` between 0 and 1.
	**/
	public static function interpolate(f:Float, a:Float, b:Float):Float
		return (b - a) * f + a;

	/**
		Checks if two angles are nearly equal, considering wrap-around.
	**/
	public static inline function nearEqualAngles(a:Float, b:Float, ?turn = 360.0, ?tollerance = Math.EPSILON):Bool
		return Math.abs(angleDifference(a, b, turn)) <= tollerance;

	/**
		Parses a float from a string.
		Recognizes optional '+' prefix, NaN, and infinities.
	**/
	public static function parse(s:String):Float {
		if (s.substring(0, 1) == "+")
			s = s.substring(1);
		return if (pattern_inf.match(s)) Math.POSITIVE_INFINITY else if (pattern_neg_inf.match(s)) Math.NEGATIVE_INFINITY else Std.parseFloat(s);
	}

	/**
		Rounds a float to the given number of decimal places.
	**/
	public static inline function precision(v:Float, digits:Int):Float {
		final factor = Math.pow(10, Math.min(Math.max(digits, 0), 15));
		return Math.round(v * factor) / factor;
	}

	/**
		Formats a float to a string with exactly the given number of decimal places, preserving trailing zeroes.
	**/
	public static inline function precisionString(v:Float, digits:Int):String {
		final parts = Std.string(precision(v, digits)).split(".");
		final whole = parts[0];
		final frac = parts.length > 1 ? parts[1] : "";
		final paddedFrac = frac.lpad("0", digits);
		return digits > 0 ? '$whole.$paddedFrac' : whole;
	}

	/**
		Returns `-1` if `value` is a negative number, `1` otherwise.
	**/
	public static inline function sign<T:Float>(v:T):Int
		return v < 0 ? -1 : 1;

	public static inline function toString(v:Float):String
		return '$v';
}
