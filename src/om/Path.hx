package om;

//TODO ! compare with js.node.Path
/*
    Convenient way of working with paths.
//@:forward(dir,file,ext,backslash,toString)
abstract Path(String) to String {
}
*/

/*
abstract Path(Array<String>) {

    public static inline var NIX_SEPERATOR = "/";
    public static inline var WIN_SEPERATOR = "\\";
    public static inline var SEPERATOR = NIX_SEPERATOR;

    //public var dir : String;
    //public var file : String;
    //public var ext : String;

    public static function create( parts : Array<String> ) {
        return new Path( parts );
    }

    @:from public static inline function fromString( s : String ) {
        return create( s.split( SEPERATOR ) );
    }

    public inline function new( a : Array<String> )
        this = a;

    public function isRelative() {
        return false;
    }

    @:to public inline function toString()
        return this.join( SEPERATOR );

}
*/


@:forward(dir,file,ext,backslash,toString)
abstract Path(haxe.io.Path) {

    public inline function new( s : String ) this = new haxe.io.Path( s );

    /*
    @:to public inline function toArray() {
        return this.split('/');
    }
    */

    @:to public inline function toString()
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
}
