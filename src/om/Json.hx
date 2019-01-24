package om;

class Json {

	public static inline function parse( str : String ) : Dynamic {
		return haxe.Json.parse( str );
	}

	public static inline function stringify( v : Dynamic, ?replacer : (key:Dynamic,value:Dynamic)->Dynamic, ?space : String ) : String {
		return haxe.Json.stringify( v, replacer, space );
	}

	#if nodejs

	public static function readFile<T>( path : String ) : Promise<T> {
		return new Promise( function(resolve,reject){
			js.node.Fs.readFile( path, { encoding : 'utf8' }, function(e,r){
				if( e != null ) reject(e) else {
					var d = try parse( r ) catch(e:Dynamic) {
						reject(e);
						return;
					}
					resolve( d );
				}
			});
		});
	}

	public static function writeFile( v : Dynamic, path : String, ?options : haxe.extern.EitherType<String,js.node.Fs.FsWriteFileOptions>, ?replacer : (key:Dynamic,value:Dynamic)->Dynamic, ?space : String ) : Promise<Nil> {
		return new Promise( (resolve,reject) -> {
			js.node.Fs.writeFile( path, stringify( v, replacer, space ), options, e -> (e != null) ? reject( e ) : resolve( om.Nil.nil ) );
		});
	}

	#elseif js

	public static inline function fetch<T>( input : haxe.extern.EitherType<js.html.Request,String>, ?init : js.html.RequestInit ) : Promise<T> {
        return FetchTools.fetchJson( input, init );
    }

	#elseif sys

	public static inline function readFile<T>( path : String ) : T {
		return parse( sys.io.File.getContent( path ) );
	}

	public static inline function writeFile( v : Dynamic, path : String, ?replacer : (key:Dynamic,value:Dynamic)->Dynamic, ?space : String ) {
		sys.io.File.saveContent( stringify( v, replacer, space ), path );
	}

	#end
}
