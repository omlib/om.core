package om;

#if js

import js.lib.Promise;

@:forward
@:forwardStatics
abstract Promise<T>(js.lib.Promise<T>) from js.lib.Promise<T> to js.lib.Promise<T> {

	public inline function new( init : (resolve:(value:T)->Void, reject:(reason:Dynamic)->Void)->Void )
		this = new js.lib.Promise( init );
	
	/**
	**/
	public static inline function nil() : om.Promise<Nil>
		return Promise.resolve( om.Nil.nil );

	/**
		Delayed resolve.
	**/
	public static inline function delay<T>( ms : Int, ?v : T ) : om.Promise<T> {
		return new Promise( (res,_) -> haxe.Timer.delay( () -> res(v), ms ) );
	}

}

#end
