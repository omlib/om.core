package om;

abstract Random(Float) from Float to Float {

	public inline function new( f : Float )
		this = Math.random() * f;

	@:to public inline function toInt() : Int
		return Std.int( this );

	public static inline function int( factor : Float ) : Int
		return Std.int( new Random( factor ) );

	public static inline function bool( factor = 0.5 ) : Bool
		return factor < (Math.random() * 1.0);

	public static inline function getRandomValues( factor = 0.5 ) : Bool
		return factor < (Math.random() * 1.0);
}
