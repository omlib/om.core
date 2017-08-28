package om;

/**
*/
abstract Path(String) from String to String {

    public static inline var SEPERATOR = '/';

    public var root(get,never) : String;
    inline function get_root() return this.split( SEPERATOR )[0];

    public var dir(get,never) : String;
    inline function get_dir() return haxe.io.Path.directory( this );

    public var ext(get,never) : String;
    inline function get_ext() return haxe.io.Path.extension( this );

    public var last(get,never) : String;
    inline function get_last() return haxe.io.Path.withoutDirectory( this );

    public inline function new( s : String ) this = s;

    public inline function isAbsolute() : Bool
        return haxe.io.Path.isAbsolute( this );

	public inline function normalize() : Path
		return this = haxe.io.Path.normalize( this );

    public inline function removeTrailingSlashes() : Path
		return this = haxe.io.Path.removeTrailingSlashes( this );

    @:to public inline function toArray() : Array<String>
		return this.split( SEPERATOR );

    @:arrayAccess
    public inline function get( i : Int ) : String
		return parts()[i];

    public inline function parts() : Array<String>
        return this.split( SEPERATOR );

    //@:arrayAccess public inline function set( i : Int, s : String ) : String

    @:from
    public static inline function fromArray( a : Array<String> ) : Path
        return new Path( a.join( SEPERATOR ) );

    public static inline function directory( path : String ) : String
        return haxe.io.Path.directory( path );

    public static inline function extension( path : String ) : String
        return haxe.io.Path.extension( path );

    public static inline function withoutExtension( path : String ) : String
        return haxe.io.Path.withoutExtension( path );
        //return haxe.io.Path.removeTrailingSlashes( path ).split( '/' ).pop();

    public static inline function withoutDirectory( path : String ) : String
        return haxe.io.Path.withoutDirectory( path );

    #if sys

    /*
    public inline function container() : Path {
        var parts = this.toArray();
        //return sys.FileSystem.isDirectory( this ) ? parts[parts.length-2];
        return parts[parts.length-2];
    }
    */

    public inline function exists() : Bool
        return sys.FileSystem.exists( this );

    public inline function isDirectory() : Bool
		return sys.FileSystem.isDirectory( this );

    public inline function content() : String
        return sys.io.File.getContent( this );

    public function delete()
		sys.FileSystem.isDirectory( this ) ? sys.FileSystem.deleteDirectory( this ) : sys.FileSystem.deleteFile( this );


	//TODO
    //public inline function rename() :
    //public inline function stat() :
    //public inline function absolute() :

    public static inline function cwdName() : String
        return haxe.io.Path.removeTrailingSlashes( Sys.getCwd() ).split( '/' ).pop();

    #end

}
