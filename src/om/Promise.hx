package om;

#if js
typedef Promise<T> = js.Promise<T>;
#else

class Promise<T> {

	//var executor : (T->Void)->(Dynamic->Void)->Void;
	var fulfillCallback : T->Void;
	var rejectCallback : T->Void;
	var _syncValue : T;
	var _syncError : Dynamic;

	public function new( executor : (T->Void)->(Dynamic->Void)->Void ) {
		executor(
			function(v){
				if( fulfillCallback != null ) {
					fulfillCallback(v);
				} else {
					_syncValue = v;
				}
			},
			function(e){
				if( rejectCallback != null ) {
					rejectCallback(e);
				} else {
					_syncError = e;
				}
			}
		);
	}

	public function then( fulfillCallback : T->Void, ?rejectCallback : Dynamic->Void ) : Promise<T> {
		if( _syncValue != null ) {
			fulfillCallback( _syncValue );
		} else if( _syncError != null && rejectCallback != null ) {
			rejectCallback( _syncError );
		} else {
			this.fulfillCallback = fulfillCallback;
			this.rejectCallback = rejectCallback;
		}
        return this;
	}

	public function catchError( rejectCallback : Dynamic->Void ) : Promise<T> {
		if( _syncError != null )
			rejectCallback( _syncError );
		else
			this.rejectCallback = rejectCallback;
		return this;
	}

	/**
		Returns a promise that either resolves when all of the promises in the iterable argument have resolved or rejects as soon as one of the promises in the iterable argument rejects.
	*/
	/*
	public static function all( iterable : Array<Dynamic> ) : Promise<Array<Dynamic>> {
		return new Promisew(function(fulfill,reject){
		});
	}
	*/

	/*
	public static function race( iterable : Array<Dynamic> ) : Promise<Dynamic> {
	}
	*/

	public static inline function resolve<T>( value : T ) : Promise<T> {
		return new Promise<T>( function(fulfill,reject) fulfill( value ) );
	}

	public static inline function reject<T>( ?value : Dynamic ) : Promise<T> {
		return new Promise<T>( function(fulfill,reject) reject( value ) );
	}

}

#end
