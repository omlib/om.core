package om.error;

import haxe.PosInfos;
import haxe.CallStack;

class ErrorType #if js extends js.lib.Error #end {

	#if !js
    public var message(default,null) : String;
    public var name(default,null) : String;
    #end

	public var pos(default,null) : PosInfos;
	public var stackItems(default,null) : Array<StackItem>;

	public var fileName(get,never) : String;
	inline function get_fileName() return pos.fileName;

	public var lineNumber(get,never) : Int;
	inline function get_lineNumber() return pos.lineNumber;

	public var methodName(get,never) : String;
	inline function get_methodName() return pos.methodName;

    public function new( ?message : String, ?stack : Array<StackItem>, ?pos : PosInfos ) {

		#if js
		super( message );
		#end
		this.message = message;

		var cl = Type.getClassName( Type.getClass( this ) );
		if( cl.indexOf( '.' ) != -1 ) cl = cl.split('.').pop();
		this.name = cl;
		this.pos = pos;

		if( stack == null ) {
			stack = try CallStack.exceptionStack() catch(e:Dynamic) [];
			if( stack.length == 0 )
				stack = try CallStack.callStack() catch(e:Dynamic) [];
		}
		this.stackItems = stack;
	}

	public inline function getCallStack() : Array<StackItem>
		return CallStack.callStack();

	public inline function getExceptionStack() : Array<StackItem>
		return CallStack.exceptionStack();

	public inline function getSourcePosition() : String
		return pos.fileName + ':' + pos.lineNumber;

	public inline function stackToString() : String
		return CallStack.toString( stackItems );

	public function toString() : String {
		var s = getSourcePosition();
		if( message != null && message.length > 0 ) s += ' : $message';
		return s + stackToString();
	}
}
