package om;

#if sys
import haxe.Json;
import sys.FileSystem;
import sys.io.File;
using om.StringTools;
#end

typedef Dependency = {
	name: String,
	version: String
}

typedef Description = {
	name : String,
	version : String,
	description : String,
	url : String,
	tags : Array<String>,
	license : String,
	classPath : String,
	releasenote : String,
	contributors : Array<String>,
	dependencies : Array<Dependency>
}

/**
	Tools to gather information on haxelib libraries.
*/
class Haxelib {

	public static inline var ENV_VAR = 'HAXELIB_PATH';
	public static inline var FILE_DESCRIPTION = 'haxelib.json';
	public static inline var FILE_CURRENT = '.current';
	public static inline var FILE_DEV = '.dev';

	#if sys

	public static var PATH(default,null) = Sys.getEnv( ENV_VAR );

	/**
		Checks if library exists in file system.
	*/
	public static inline function exists( lib : String ) : Bool {
		return FileSystem.exists( getPath( lib.replace('.',',') ) );
	}

	/**
		Returns the library path without checking existence.
	*/
	public static inline function getPath( lib : String ) : String {
		return PATH+'/'+lib.replace('.',',');
	}

	/**
		Returns the library path, also checks if exists in file system.
		If active is set true the full path to active library is returned.
		If library is in 'dev' mode path to development directory is returned.
	*/
	public static function resolvePath( lib : String, active = false ) : String {
		var p = getPath( lib );
		if( active ) {
			var a = getActiveVersion( lib );
			if( a == 'dev' ) p = File.getContent( '$p/.dev' ).trim();
			else p += '/$a';
		}
		return FileSystem.exists( p ) ? p : null;
	}

	/**
		Returns availble library versions.
	*/
	public static function getVersions( lib : String ) : Array<String> {
		var path = getPath( lib );
		var versions = FileSystem.readDirectory( path ).filter( e -> {
			if( !FileSystem.isDirectory( '$path/$e' ) )
				return false;
			return switch e {
			case 'git','dev','hg': true;
		 	default: SemVer.isValid( e.replace(',','.') );
			}
		});
		if( FileSystem.exists( '$path/.dev' ) ) versions.push( 'dev' );
		var cur = '$path/.current';
		/*
		//TODO active first
		if( FileSystem.exists( 'cur' ) ) {
			var a = File.getContent( cur ).trim();
		}
		*/
		return versions;
	}

	/**
		Returns the active version of the library.
	*/
	public static function getActiveVersion( lib : String ) : String {
		var p = getPath( lib );
		var cur = '$p/$FILE_CURRENT';
		if( FileSystem.exists( 'cur' ) )
			return File.getContent( cur ).trim();
		if( FileSystem.exists( '$p/$FILE_DEV' ) )
			return 'dev';
		return null;
	}

	/**
	*/
	public static inline function getDescription( lib : String ) : Description {
		var p = resolvePath( lib, true );
		return Json.parse( File.getContent( '$p/$FILE_DESCRIPTION' ) );
	}

	#end

}
