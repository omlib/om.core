package om;

@:forward(backslash,dir,ext,file)
@:forwardStatics
abstract Path(haxe.io.Path) {

    public inline function new( s : String ) this = new haxe.io.Path( s );

    @:to public inline function toString() : String
        return this.toString();

	/*
		@:to public inline function toArray() {
		return this.split('/');
	}
	*/

	@:from public static inline function fromString( s : String ) : om.Path
		return new om.Path(s);

}
