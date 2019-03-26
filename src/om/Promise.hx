package om;

#if js

import js.Promise;

@:forward
@:forwardStatics
abstract Promise<T>(js.Promise<T>) from js.Promise<T> to js.Promise<T> {

	public inline function new( init : (resolve:(value:T)->Void, reject:(reason:Dynamic)->Void)->Void )
		this = new js.Promise( init );
	
	/**
	**/
	public static inline function nil() : Promise<Nil>
		return Promise.resolve( om.Nil.nil );

	/**
		Delayed resolve.
	**/
	public static inline function delay<T>( ms : Int, ?v : T ) : om.Promise<T> {
		return new Promise( (res,_) -> haxe.Timer.delay( () -> res(v), ms ) );
	}

}

#end
