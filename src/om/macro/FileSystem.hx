package om.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

using StringTools;
using haxe.io.Path;
using om.macro.MacroTools;
using om.util.StringUtil;

#end

typedef FileStat = {
	/** the user group id for the file **/
	var gid : Int;
	/** the user id for the file **/
	var uid : Int;
	/** the last access time for the file (when enabled by the file system) **/
	var atime : Date;
	/** the last modification time for the file **/
	var mtime : Date;
	/** the creation time for the file **/
	var ctime : Date;
	/** the size of the file **/
	var size : Int;
	var dev : Int;
	var ino : Int;
	var nlink : Int;
	var rdev : Int;
	var mode : Int;
}

/**
	Emulates the sys.FileSystem API for (non-sys targets) at compile time.
*/
class FileSystem {

	macro public static function exists( path : String ) : ExprOf<Bool> {
		return Context.makeExpr( sys.FileSystem.exists( path ), Context.currentPos() );
	}

	macro public static function rename( path : String, newPath : String ) : Expr {
		sys.FileSystem.rename( path, newPath );
		return macro null;
	}

	macro public static function stat( path : String ) : ExprOf<FileStat> {
		var s = sys.FileSystem.stat( path );
		var atime = s.atime.dateToExpr();
		var mtime = s.mtime.dateToExpr();
		var ctime = s.ctime.dateToExpr();
		return macro {
			gid: $v{s.gid},
			uid: $v{s.uid},
			atime: $atime,
			mtime: $mtime,
			ctime: $ctime,
			size: $v{s.size},
			dev: $v{s.dev},
			ino: $v{s.ino},
			nlink: $v{s.nlink},
			rdev: $v{s.rdev},
			mode: $v{s.mode},
		};
	}

	macro public static function fullPath( relPath : String ) : ExprOf<String> {
		return Context.makeExpr( sys.FileSystem.fullPath( relPath ), Context.currentPos() );
	}

	macro public static function absolutePath( relPath : String ) : ExprOf<String> {
		return Context.makeExpr( sys.FileSystem.absolutePath( relPath ), Context.currentPos() );
	}

	macro public static function isDirectory( path : String ) : ExprOf<Bool> {
		return Context.makeExpr( sys.FileSystem.isDirectory( path ), Context.currentPos() );
	}

	macro public static function createDirectory( path : String ) : Expr {
		sys.FileSystem.createDirectory( path );
		return Context.makeExpr( null, Context.currentPos() );
	}

	macro public static function deleteFile( path : String ) : Expr {
		sys.FileSystem.deleteFile( path );
		return Context.makeExpr( null, Context.currentPos() );
	}

	macro public static function deleteDirectory( path : String ) : Expr {
		sys.FileSystem.deleteDirectory( path );
		return Context.makeExpr( null, Context.currentPos() );
	}

	macro public static function readDirectory( path : String ) : ExprOf<Array<String>> {
		return Context.makeExpr( sys.FileSystem.readDirectory( path ), Context.currentPos() );
	}

	////////////////////////////////////////////////////////////////////////////

	macro public static function fileSize( path : String ) : ExprOf<Int> {
		return Context.makeExpr( sys.FileSystem.stat( path ).size, Context.currentPos() );
	}

	macro public static function getContent( path : String ) : ExprOf<String> {
		return Context.makeExpr( File.getContent( path ), Context.currentPos() );
	}

	macro public static function getJSON<T>( path : String ) : ExprOf<T> {
		//var str = loadFileAsString( path );
		var str = File.getContent( path );
		var data : T = null;
        try data = Json.parse(str) catch(e:Dynamic) {
			var msg = Std.string(e);
			var pos = Std.parseInt( msg.substr( msg.lastIndexOf(' ') ) ) + 1;
			var line = str.substring( 0, pos ).countLines();
            return Context.error( 'Invalid json: $path line:$line pos:$pos', Context.currentPos() );
        }
		return data.toExpr();
	}

	/*
	#if macro

	static function loadFileAsString( path : String ) {
		try {
			var p = Context.resolvePath( path );
			Context.registerModuleDependency( Context.getLocalModule(), p );
			return sys.io.File.getContent(p);
		} catch( e : Dynamic ) {
			return Context.error( 'Failed to load file $path: $e', Context.currentPos() );
		}
	}

	#end
	*/


	/*
	macro public static function readXmlFile( path : String ) : ExprOf<String> {
        var str = sys.io.File.getContent( path );
        try Xml.parse(str) catch(e:Dynamic) {
			Context.error( 'Invalid xml : $path : $e', Context.currentPos() );
        }
        return Context.makeExpr( str, Context.currentPos() );
    }
	*/

    /**
    */
	/*
	//macro public static function findFiles( path : String, ?extensions : Array<String>, recursive : Bool = false ) : ExprOf<Array<String>> {
	macro public static function findFiles( path : String, ?extensions : Array<String> ) : ExprOf<Array<String>> {

		//TODO recursive

		var found = new Array<String>();

		//__findFiles( found, path, extensions, recursive );
		__findFiles( found, path, extensions );

		/*
		for( f in sys.FileSystem.readDirectory( path ) ) {
			var p = '$path/$f';
			if( sys.FileSystem.isDirectory(p) ) {
				continue;
			}
			if( extensions != null ) {
				var hasFileExtension = false;
				for( ext in extensions ) {
					if( f.endsWith( ext ) ) {
						hasFileExtension = true;
						break;
					}
				}
				if( hasFileExtension ) {
					found.push( f.withoutExtension() );
				}
			} else {
				found.push( p );
			}
		}

		trace(found);
		*/

		/*
		__findFiles( found, path, extensions, recursive );
		//trace( found );
		* /


		return Context.makeExpr( found, Context.currentPos() );
	}
	*/

	/*
	#if macro

	//static function __findFiles( found : Array<String>, path : String, extensions : Array<String>, recursive : Bool ) {
	static function __findFiles( found : Array<String>, path : String, extensions : Array<String> ) {
		for( f in sys.FileSystem.readDirectory( path ) ) {
			var p = '$path/$f';
			if( sys.FileSystem.isDirectory(p) ) {
				//if( recursive ) __findFiles( found, p, extensions, recursive );
				continue;
			}
			if( extensions != null ) {
				var hasFileExtension = false;
				for( ext in extensions ) {
					if( f.endsWith( ext ) ) {
						hasFileExtension = true;
						break;
					}
				}
				if( hasFileExtension ) {
					found.push( f.withoutExtension() );
				}
			} else {
				found.push( p );
			}
		}
	}
	*/

	/*
	static function __findFiles( found : Array<String>, path : String, extensions : Array<String>, recursive : Bool ) {
		for( f in sys.FileSystem.readDirectory( path ) ) {
			var p = '$path/$f';
			if( sys.FileSystem.isDirectory( p ) ) {
				if( recursive )
					__findFiles( found, p, extensions, recursive );
				continue;
			}
			p = p.substr( p.indexOf("/")+1 );
			trace(extensions);
			if( extensions != null ) {
				//trace(extensions);
				for( ext in extensions ) {
					if( !f.endsWith( ext ) ) {
						continue;
					}
				}
		//		trace(f);
				found.push( f.withoutExtension() );
				//found.push( p );
			} else {
				found.push( p );
			}
		}
	}

	#end
	*/

}
