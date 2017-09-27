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
			Returns random float.
	*/
	public static inline function float( seed : Float ) : Float
		return new Random( seed );


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

	/**
		Murmur3 is a non-cryptographic hash, designed to be fast and excellent-quality for making things like hash tables or bloom filters.
	*/
	public static function murmur3( n : Int, seed: Int ) : haxe.Int32 {
		var n : haxe.Int32 = n;
		n *= 0xcc9e2d51;
		n = (n << 15) | (n >>> 17);
		n *= 0x1b873593;
		var h : haxe.Int32 = seed;
		h ^= n;
		h = (h << 13) | (h >>> 19);
		h = h*5 + 0xe6546b64;
		h ^= h >> 16;
		h *= 0x85ebca6b;
		h ^= h >> 13;
		h *= 0xc2b2ae35;
		h ^= h >> 16;
		return h;
	}
}
