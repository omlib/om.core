package om;

abstract Char(Int) to Int {
	inline function new(i:Int)
		this = i;

	public function isControl():Bool
		return (this >= 0x0000 && this <= 0x001F) || this == 0x007F || (this >= 0x0080 && this <= 0x009F);

	public inline function isUnicode():Bool
		return this <= 0xFFFD;

	public inline function next():Char
		return this + 1;

	public inline function prev():Char
		return this - 1;

	@:to public inline function toString():String
		return String.fromCharCode(this);

	@:from public static inline function fromInt(i:Int):Char
		return (i <= 0) ?throw 'invalid char' : new Char(i);

	@:from public static inline function fromString(s:String):Char
		return s.charCodeAt(0);
}
