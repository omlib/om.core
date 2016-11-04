package om;

#if ( js && om_native_promise )
typedef Promise<T> = js.Promise<T>;
#else

#if !om_unit_test private #end
enum EPromiseOrValue<T> {
	EPromise( promise : Promise<T> );
	EValue( value : T );
	//ENull;
}

#if !om_unit_test private #end
abstract PromiseOrValue<T>(EPromiseOrValue<T>) {

	public inline function new( pov : EPromiseOrValue<T> ) this = pov;

	public function isPromise() : Bool {
		return switch this {
			case EPromise(_): true;
			case EValue(_): false;
		}
	}

	public function isValue() : Bool {
		return switch this {
			case EValue(_): true;
			case EPromise(_): false;
		}
	}

	@:to public function toPromise() : Promise<T> {
		return switch this {
			case EPromise(p): p;
			case EValue(v): Promise.resolve( v );
			//case ENull: Promise.fulfilled( null );
		}
	}

	@:from public static inline function fromPromise<T>( promise : Promise<T> ) : PromiseOrValue<T>
		return new PromiseOrValue( EPromise( promise ) );

	@:from public static inline function fromValue<T>( value : Null<T> ) : PromiseOrValue<T>
		return new PromiseOrValue( EValue( value ) );
}

private class CReason {

	public var value(default,null) : Dynamic;

	public inline function new( value : Dynamic ) {
		this.value = value;
	}

	/*
	public function toString() : String {
	  //var stackString = CallStack.toString(stack);
	  //return 'Rejection reason from: ${pos.className}.${pos.methodName}() at ${pos.lineNumber}${stackString}\n';
	  return 'Rejection reason: '+value;
	}
	*/
}

@:forward(value)
abstract Reason(CReason) {

	public inline function new( ?value : Dynamic ) this = new CReason( value );

	@:to public inline function toString() : String
		return return 'Rejection reason: '+this.value; //this.toString();

	//@:from public static inline function fromString( str : String ) : Reason
	//	return new Reason( str );

	@:from public static inline function fromDynamic( value : Dynamic ) : Reason
		return Std.is( value, CReason ) ? cast value : new Reason( value );
}

@:enum abstract PromiseState(Int) from Int to Int {

	/** Initial state, not fulfilled or rejected. */
	var Pending = 0;

	/** The operation completed successfully */
	var Fulfilled = 1;

	/** The operation failed */
	var Rejected = -1;
}

class Promise<T> {

	static var nextTick : (Void->Void)->Void;

	public var state(default,null) : PromiseState;
	public var value(default,null) : T;
	public var reason(default,null)  : Reason;

	var fulfillHandlers : Array<T->Void>;
	var rejectHandlers : Array<Reason->Void>;

	public function new( resolver : ((T->Void)->(Reason->Void)->Void) ) {

		if( nextTick == null ) nextTick = Time.createNextTickProvider();

		this.state = Pending;
		this.fulfillHandlers = [];
		this.rejectHandlers = [];

		try {
			resolver( setFulfilled, setRejected );
		} catch( reason : Reason ) {
			setRejected( reason );
		} catch( e : Dynamic ) {
			setRejected( e );
		}
	}

	public inline function isPending() : Bool {
		return state == Pending;
		/*
		return switch state {
		case Pending: true;
		case _: false;
		}
		*/
	}

	public inline function isFulfilled() : Bool {
		return state == Fulfilled;
		/*
		return switch state {
		case Fulfilled: true;
		case _: false;
		}
		*/
	}

	public inline function isRejected() : Bool {
		return state == Rejected;
		/*
		return switch state {
		case Rejected: true;
		case _: false;
		}
		*/
	}

	public function then<N>( ?onFulfilled : T->PromiseOrValue<N>, ?onRejected : Reason->PromiseOrValue<N> ) : Promise<N> {
		return new Promise( function( resNext : N->Void, rejNext : Reason->Void ) {
			switch state {
			case Pending:
				addFulfillHandler( onFulfilled, resNext, rejNext );
				addRejectHandler( onRejected, resNext, rejNext );
			case Fulfilled:
				addFulfillHandler( onFulfilled, resNext, rejNext );
	            notifyOnNextTick();
			case Rejected:
				addRejectHandler( onRejected, resNext, rejNext );
	            notifyOnNextTick();
			}
		} );
	}

	public function end(
		?onFulfillment : T->Void,
		?onRejection : Reason->Void ) : Promise<Nil> {

		var wrappedOnFulfillment : T->PromiseOrValue<Nil> = null;
		var wrappedOnRejection : Reason->PromiseOrValue<Nil> = null;
		if( onFulfillment != null ) {
			wrappedOnFulfillment = function(value) {
				return new Promise( function(resolve,reject) {
					onFulfillment( value );
					resolve( Nil.nil );
	    		});
	      	};
	    }
	    if( onRejection != null ) {
			wrappedOnRejection = function(reason) {
				return new Promise( function(resolve,reject) {
					onRejection( reason );
					// Resolve this to nil unless onRejection throws - this way the rejection is "handled"
					resolve( Nil.nil );
	        	});
	      	};
	    }
	    return then( wrappedOnFulfillment, wrappedOnRejection );
	}

	public function delay( ms : Int ) : Promise<T> {
		return then( function(value) {
			return Promise.delayed( ms, value );
		});
	}

	public function catches<N>( onRejection : Reason->PromiseOrValue<N> ) : Promise<N> {
		return then( null, onRejection );
    }

	public function catchesEnd( onRejection : Reason->Void ) : Promise<Nil> {
		return end( null, onRejection );
    }

	function setFulfilled( value : T ) {
		switch state {
		case Pending:
			this.value = value;
			state = Fulfilled;
			notifyOnNextTick();
		case other:
			throw 'Promise cannot change from $other to Fulfilled';
		}
	}

	function setRejected( reason : Dynamic ) {
		switch state {
		case Pending:
			this.reason = reason;
			state = Rejected;
			notifyOnNextTick();
		case other:
			throw 'Promise cannot change from $other to Rejected';
		}
	}

	function addFulfillHandler<N>(
		?onFulfillment : T->PromiseOrValue<N>,
		resolveNext : N->Void,
		rejectNext : Reason->Void ) {

		// If there is no fulfillment handler, we can't pass the current T along, because its expecting a N.
		if( onFulfillment == null ) {
			return;
		}

		fulfillHandlers.push( function(value) {
			try {
				onFulfillment( value ).toPromise().end( resolveNext, rejectNext );
			} catch( reason : Reason ) {
				rejectNext( reason );
			} catch( e : Dynamic ) {
				rejectNext( e );
			}
		} );
	}

	function addRejectHandler<N>(
        ?onRejection : Reason->PromiseOrValue<N>,
        resolveNext : N->Void,
		rejectNext : Reason->Void ) {

		if( onRejection == null ) {
			onRejection = function( reason ) {
				return Promise.reject( reason );
	        };
		}

		rejectHandlers.push( function(value) {
			try {
				onRejection( value ).toPromise().end( resolveNext, rejectNext );
	        } catch( reason : Reason ) {
				rejectNext( reason );
	        } catch( e : Dynamic ) {
				rejectNext(e);
	        }
		} );
	}

	function notifyOnNextTick() {
		nextTick( function() {
			switch state {
			case Fulfilled:
				for( l in fulfillHandlers ) l( value );
				fulfillHandlers = [];
			case Rejected:
				for( l in rejectHandlers ) l( reason );
				rejectHandlers = [];
			case _: // No-op
			}
		} );
	}

	/**
		Returns a promise that either resolves when all of the promises in the iterable argument have resolved
		or rejects as soon as one of the promises in the iterable argument rejects.

		If the returned promise fulfills, it is fulfilled with an array of the values
		from the fulfilled promises in same order as defined in the iterable.

		If the returned promise rejects, it is rejected with the reason from the first promise in the iterable that rejected.
		This method can be useful for aggregating results of multiple promises.
	*/
	public static inline function all( inputs : Array<PromiseOrValue<Dynamic>> ) : Promise<Array<Dynamic>> {
		var totalCount = inputs.length;
	    var isSettled = false;
	    var fulfillmentCount = 0;
	    var rejectionCount = 0;
	    var fulfillments : Array<Dynamic> = [];
	    var rejections : Array<Reason> = [];
	    return new Promise(
			function(resolve,reject) {
	    		for( i in 0...totalCount ) {
	        		if( inputs[i] == null )
						throw new Reason( 'Promise.all: null inputs not allowed' );
	        		inputs[i].toPromise().end( function(value) {
	            		fulfillmentCount++;
	            		if( !isSettled ) {
	            			fulfillments[i] = value;
	              			if( fulfillmentCount == totalCount ) {
	                			isSettled = true;
	                			resolve( fulfillments );
	            			}
	            		}
	        		}, function(reason) {
	        			rejectionCount++;
	            		if( !isSettled ) {
	            			rejections[i] = reason;
	              			isSettled = true;
	             			reject(rejections);
	            		}
	        		});
	    		}
			}
		);
	}

	public static inline function resolve<T>( value : T ) : Promise<T>
		return new Promise( function(resolve,_) resolve( value ) );

	public static inline function reject<T>( reason : Reason ) : Promise<T>
		return new Promise( function(_,reject) reject( reason ) );

	public static inline function nil() : Promise<Nil>
		return new Promise( function(resolve,_) resolve( Nil.nil ) );

	public static function delayed<T>( ms : Int, ?value : T ) : Promise<T> {
		return new Promise( function(resolve,reject) {
			haxe.Timer.delay( function() resolve( value ), ms );
	    });
	}
}

#end
