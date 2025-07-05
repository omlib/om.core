package om;

@:pure
abstract Pair<A, B>(CPair<A, B>) {
	public var a(get, never):A;

	inline function get_a():A
		return this.a;

	public var b(get, never):B;

	inline function get_b():B
		return this.b;

	public inline function new(a:A, b:B)
		this = new CPair(a, b);

	@:to inline function toArray():Array<Dynamic>
		return [this.a, this.b];

	@:to inline function toBool():Bool
		return this != null;

	@:op(!a) inline function isNull():Bool
		return this == null;
}

private class CPair<A, B> {
	public var a:A;
	public var b:B;

	public inline function new(a:A, b:B) {
		this.a = a;
		this.b = b;
	}
}
