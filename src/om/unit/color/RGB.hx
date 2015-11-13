package om.unit.color;

//import om.util.ColorParser;
import om.util.ColorUtil;

abstract RGB(Int) from Int to Int {

	public static inline function create( r : Int, g : Int, b : Int ) : RGB
        return new RGB(((r & 0xFF) << 16) | ((g & 0xFF) << 8) | ((b & 0xFF) << 0));

	public var r(get,never) : Int;
	public var g(get,never) : Int;
	public var b(get,never) : Int;

	public inline function new( i : Int ) this = i;

	inline function get_r() return this >> 16 & 0xFF;
	inline function get_g() return this >> 8 & 0xFF;
	inline function get_b() return this & 0xFF;

	@:op(A==B) public function equals( other : RGB ) : Bool
		return r == other.r && g == other.g && b == other.b;

	@:to public inline function toArray() : Array<Int>
		return [r,g,b];

	@:to public inline function toString() : String
		return '#'+untyped this.toString(16);

	//public inline function toHex( prefix = '#' ) : String
	//	return '$prefix${r.hex(2)}${g.hex(2)}${b.hex(2)}';

	public inline function toCSS3() : String
		return 'rgb($r,$g,$b)';

	@:arrayAccess
	public function getPart( i : Int ) : Int {
		return switch i {
			case 0: r;
			case 1: g;
			case 2: b;
			default: throw 'Out of bounds';
		}
	}

	public function interpolate( target : Int, ratio = 0.5 ) : RGB {
		var _target = new RGB( target );
		var _r = r;
		var _g = g;
		var _b = b;
		return ColorUtil.rgbToInt(
			Std.int( _r + (_target.r - _r) * ratio ),
			Std.int( _g + (_target.g - _g) * ratio ),
			Std.int( _b + (_target.b - _b) * ratio )
		);
	}

	@:from static inline function fromInt( i : Int )
		return new RGB(i);

	@:from static inline function fromString( s : String ) : Null<RGB> {
		/*
		var info = ColorParser.parseHex( color );
		if( info == null )
			info = ColorParser.parseColor(color);
		if( info == null )
			return null;
		trace(info);
		return null;
		*/
		return new RGB( ColorUtil.strToInt( s ) );
	}

	@:from static inline function fromArray( a : Array<Int> )
		return new RGB( ColorUtil.rgbToInt( a[0], a[1], a[2] ) );

}
