package om;

abstract Random(Float) from Float to Float {

	public inline function new( seed : Float )
		this = Math.random() * seed;

	@:to public inline function toInt() : Int
		return Std.int( this );

	/**
		Returns random Bool.
	*/
	public static inline function bool( factor = 0.5 ) : Bool
		return factor < (Math.random() * 1.0);

	/**
		Returns random Int.
	*/
	public static inline function int( seed : Float ) : Int
		return Std.int( new Random( seed ) );


	/*
	public static inline function getRandomValues( factor = 0.5 ) : Bool
		return factor < (Math.random() * 1.0);
	*/

	/*
	public static function getRandomString( length : Int ) : String {

		#if nodejs
        return js.node.Crypto.randomBytes( length ).toString( 'hex' ).substr( 0, length );

		var charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        var values = new js.html.Uint32Array( length );
        window.crypto.getRandomValues( values );
        var str = "";
        for( i in 0...length ) result += charset.charAt( values[i] % charset.length );
        return str;
	}
	*/
}
