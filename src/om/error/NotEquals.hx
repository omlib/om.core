package om.error;

class NotEquals<T> extends ErrorType {

	public var a(default,null) : T;
	public var b(default,null) : T;

	public inline function new( a : T, b : T, ?pos : haxe.PosInfos ) {
		super( '[$a] not equals [$b]', pos );
		this.a = a;
		this.b = b;
	}

}
