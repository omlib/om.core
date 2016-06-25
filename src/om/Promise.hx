package om;

#if (js && om_native_promise)
typedef Promise<T> = js.Promise<T>;

#else

@:enum abstract PromiseStatus(String) {

	/** Initial state, not fulfilled or rejected. */
	var pending = "pending";

	/** The operation completed successfully */
	var fulfilled = "fulfilled";

	/** The operation failed */
	var rejected = "rejected";
}

class Promise<T> {

	public var state(default,null) : PromiseStatus = pending;

	//var executor : (T->Void)->(Dynamic->Void)->Void;

	var onFulfilled : T->Void;
	var onRejected : T->Void;

	var _syncValue : T;
	var _syncError : Dynamic;

	public function new( executor : (T->Void)->(Dynamic->Void)->Void ) {
		executor(
			function(v){
				if( onFulfilled != null ) {
					onFulfilled( v );
				} else {
					_syncValue = v;
				}
			},
			function(e){
				if( onRejected != null ) {
					onRejected( e );
				} else {
					_syncError = e;
				}
			}
		);
	}

	/**
		Appends fulfillment and rejection handlers to the promise, and returns a new promise resolving to the return value of the called handler, or to its original settled value if the promise was not handled (i.e. if the relevant handler onFulfilled or onRejected is undefined).
	*/
	public function then( onFulfilled : T->Void, ?onRejected : Dynamic->Void ) : Promise<T> {
		if( _syncValue != null ) {
			onFulfilled( _syncValue );
		} else if( _syncError != null && onRejected != null ) {
			onRejected( _syncError );
		} else {
			this.onFulfilled = onFulfilled;
			this.onRejected = onRejected;
		}
        return this;
	}

	/**
		Appends a rejection handler callback to the promise, and returns a new promise resolving to the return value of the callback if it is called, or to its original fulfillment value if the promise is instead fulfilled.
	*/
	public function catchError( onRejected : Dynamic->Void ) : Promise<T> {
		if( _syncError != null )
			onRejected( _syncError );
		else
			this.onRejected = onRejected;
		return this;
	}

	/**
		Returns a Promise object that is resolved with the given value.
		If the value is a thenable (i.e. has a then method), the returned promise will "follow" that thenable, adopting its eventual state; otherwise the returned promise will be fulfilled with the value. Generally, if you want to know if a value is a promise or not - Promise.resolve(value) it instead and work with the return value as a promise.
	*/
	public static inline function resolve<T>( value : T ) : Promise<T> {
		return new Promise<T>( function(fulfill,reject) fulfill( value ) );
	}

	/**
		Returns a Promise object that is rejected with the given reason.
	*/
	public static inline function reject<T>( ?value : Dynamic ) : Promise<T> {
		return new Promise<T>( function(fulfill,reject) reject( value ) );
	}

	/**
		Returns a promise that either resolves when all of the promises in the iterable argument have resolved or rejects as soon as one of the promises in the iterable argument rejects.
		If the returned promise resolves, it is resolved with an array of the values from the resolved promises in the iterable.
		If the returned promise rejects, it is rejected with the reason from the promise in the iterable that rejected.
		This method can be useful for aggregating results of multiple promises together.
	*/
	public static function all( iterable : Array<Dynamic> ) : Promise<Array<Dynamic>> {
		//TODO
		return new Promise(function(fulfill,reject){
		});
	}

	/**
		Returns a promise that resolves or rejects as soon as one of the promises in the iterable resolves or rejects, with the value or reason from that promise.
	*/
	public static function race( iterable : Array<Promise<Dynamic>> ) : Promise<Dynamic> {
		return new Promise( function(resolve,reject) {

		});
	}
}

#end
