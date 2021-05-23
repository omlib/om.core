package om;

@:forward
abstract RegExp(EReg) from EReg to EReg {

	public inline function new( r : String, opt = "" )
		this = new EReg( r, opt );

	@:from static inline function fromString( s : String ) : RegExp
		return new RegExp( s );
}
