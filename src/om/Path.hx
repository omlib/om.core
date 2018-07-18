package om;

/**
	Abstract over `haxe.io.Path`
*/
@:forward(backslash,dir,ext,file)
abstract Path(haxe.io.Path) {

    public inline function new( str : String ) this = new haxe.io.Path( str );

	//TODO remove empty parts ?
    @:to public inline function toArray() : Array<String>
        return this.toString().split('/');

    @:to public inline function toString() : String
        return this.toString();

	public static function addTrailingSlash( path : String ) : String
		return haxe.io.Path.addTrailingSlash( path );

	public static function directory( path : String ) : String
		return haxe.io.Path.directory( path );

	public static function extension( path : String ) : String
		return haxe.io.Path.extension( path );

	public static inline function isAbsolute( path : String ) : Bool
		return haxe.io.Path.isAbsolute( path );

	public static function join( paths : Array<String> ) : String
		return haxe.io.Path.join( paths );

	public static function normalize( path : String ) : String
		return haxe.io.Path.normalize( path );

	public static inline function removeTrailingSlashes( path : String ) : String
		return haxe.io.Path.removeTrailingSlashes( path );

	public static inline function withExtension( path : String, ext : String ) : String
		return haxe.io.Path.withExtension( path, ext );

	public static inline function withoutDirectory( path : String ) : String
		return haxe.io.Path.withoutDirectory( path );

	public static inline function withoutExtension( path : String ) : String
		return haxe.io.Path.withoutExtension( path );

	@:from public static inline function fromString( s : String ) : om.Path
		return new om.Path(s);

}
