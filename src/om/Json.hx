package om;

class Json {

	public static inline function parse( str : String ) : Dynamic {
		return haxe.Json.parse( str );
	}

	public static inline function stringify( v : Dynamic, ?replacer : (key:Dynamic,value:Dynamic)->Dynamic, ?space : String  ) : String {
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

	#elseif sys

	public static inline function readFile( path : String ) : Dynamic {
		return parse( sys.io.File.getContent( path ) );
	}

	#end
}
