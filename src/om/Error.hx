package om;

import haxe.PosInfos;
import haxe.CallStack;

class Error
#if js extends js.Error #end
{
	public var pos(default,null) : PosInfos;

	#if !js
    public var message(default,null) : String;
    public var name(default,null) : String;
    #end

	public var fileName(get,null) : String;
	inline function get_fileName() return pos.fileName;

	public var lineNumber(get,null) : Int;
	inline function get_lineNumber() return pos.lineNumber;

	public var methodName(get,null) : Int;
	inline function get_methodName() return pos.methodName;

	public function new( ?message : String, ?pos : PosInfos ) {

		#if js
		super( message );
		#end
		this.message = message;
		this.pos = pos;

		var clName = Type.getClassName( Type.getClass(this) );
		if( clName.indexOf( '.' ) != -1 ) clName = clName.split('.').pop();
		this.name = clName;
	}

	public function toString() : String {
		var items = getExceptionStack();
		if( items.length == 0 ) items = getCallStack();
		return getSourcePosition() + ' : ' + message + CallStack.toString( items );
	}

	public inline function getSourcePosition() : String
	    return pos.fileName + ':' + pos.lineNumber;

	public inline function getCallStack() : Array<StackItem>
		return CallStack.callStack();

	public inline function callStack() : String
		return CallStack.toString( CallStack.callStack() );

	public inline function getExceptionStack() : Array<StackItem>
		return CallStack.exceptionStack();

	public inline function exceptionStack() : String
		return CallStack.toString( CallStack.exceptionStack() );

	//public function getStackString() : String
	//    return CallStack.toString( items );
}
