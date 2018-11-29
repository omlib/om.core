package om;

import haxe.PosInfos;
import haxe.CallStack;
import om.error.ErrorType;

@:forward(message,pos,stackItems,getCallStack,getExceptionStack,getSourcePosition,stackToString)
abstract Error(ErrorType) {

	@:from public inline static function fromString( str : String ) : Error
		return new Error( str );

	public inline function new( ?message : String, ?stack : Array<StackItem>, ?pos : PosInfos )
		this = new ErrorType( message, stack, pos );

	@:to public inline function toString() : String
		return this.toString();

}
