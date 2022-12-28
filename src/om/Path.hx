package om;

/**
	Abstract over `haxe.io.Path`
**/

@:forward(backslash,dir,ext,file)
abstract Path(haxe.io.Path) {

	public static inline var SEPERATOR = '/';

    public inline function new( s : String ) this = new haxe.io.Path( s );

	/**
		Returns the last element of path.
		TODO Trailing slashes are removed before extracting the last element.
		TODO If the path is empty, Base returns ".".
		TODO If the path consists entirely of slashes, Base returns "/".
	**/
	public inline function base() : String
		return this.dir;

	//TODO remove empty parts ?
    @:to public inline function toArray() : Array<String>
        return this.toString().split( SEPERATOR );

    @:to public inline function toString() : String
        return this.toString();
	
	public static inline function addTrailingSlash( path : String ) : String
		return haxe.io.Path.addTrailingSlash( path );

 	public static inline function directory( path : String ) : String
		return haxe.io.Path.directory( path );

 	public static inline function extension( path : String ) : String
		return haxe.io.Path.extension( path );

 	public static inline function isAbsolute( path : String ) : Bool
		return haxe.io.Path.isAbsolute( path );

 	public static inline function join( paths : Array<String> ) : String
		return haxe.io.Path.join( paths );

 	public static inline function normalize( path : String ) : String
		return haxe.io.Path.normalize( path );

 	public static inline function removeTrailingSlashes( path : String ) : String
		return haxe.io.Path.removeTrailingSlashes( path );

 	public static inline function withExtension( path : String, ext : String ) : String
		return haxe.io.Path.withExtension( path, ext );

 	public static inline function withoutDirectory( path : String ) : String
		return haxe.io.Path.withoutDirectory( path );

 	public static inline function withoutExtension( path : String ) : String
		return haxe.io.Path.withoutExtension( path );

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
