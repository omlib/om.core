package om;

/**
	Abstract over `haxe.io.Path`
*/
@:forward(backslash,dir,ext,file)
@:forwardStatics(addTrailingSlash,directory,extension,isAbsolute,join,normalize,removeTrailingSlashes,withExtension,withoutDirectory,withoutExtension)
abstract Path(haxe.io.Path) {

	public static inline var SEPERATOR = '/';

    public inline function new( str : String )
		this = new haxe.io.Path( str );

	//TODO remove empty parts ?
    @:to public inline function toArray() : Array<String>
        return this.toString().split( SEPERATOR );

    @:to public inline function toString() : String
        return this.toString();

	@:from public static inline function fromArray( a : Array<String> ) : om.Path
		return om.Path.join( a );

	@:from public static inline function fromList( l : List<String> ) : om.Path
		return fromString( om.Path.normalize( l.join( SEPERATOR ) ) );

	@:from public static inline function fromString( s : String ) : om.Path
		return new om.Path( s );

	// --- Extra methods

	public static function hasExtension( path : String, ?ext : String ) : Bool {
		return (ext == null)
			? Path.extension( path ).length > 0
			: Path.extension( path ) == ext;
	}

	public static function replaceExtension( path : String, ?ext : String ) : String {
		return switch ext {
			case null: Path.withoutExtension( path );
			case _ if( ext.length == 0 ): throw 'invalid extension';
			default: Path.withoutExtension( path ) + '.$ext';
		}
	}

}
