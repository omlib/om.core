package om.util;

class IntUtil {

	public static inline function abs( i : Int ) : Int
		return i < 0 ? -i : i;

	public static inline function even( i : Int ) : Bool
		return i & 1 == 0;

	public static inline function uneven( i : Int ) : Bool
		return i & 1 == 1;

	public static inline function clamp( i : Int, min : Int, max : Int ) : Int
    	return i < min ? min : (i > max ? max : i);

	public static inline function compare( a : Int, b : Int ) : Int
	    return a - b;

	public static inline function min( a : Int, b : Int ) : Int
	    return a < b ? a : b;

	public static inline function max( a : Int, b : Int ) : Int
		return a > b ? a : b;

	//public static inline function random( min = 0, max : Int ) : Int

	public static inline function sign( i : Int ) : Int
	    return i < 0 ? -1 : 1;

	public static inline function toBool( i : Int ) : Bool
    	return i != 0;

	public static inline function random( min = 0, max : Int )
		return Std.random( max + 1 ) + min;

}
