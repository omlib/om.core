package om;

import haxe.PosInfos;
import haxe.CallStack;

class Error #if js extends js.Error #end {

	public var pos(default,null) : PosInfos;

	#if !js
    public var message(default,null) : String;
    public var name(default,null) : String;
    #end

	public var fileName(get,never) : String;
	inline function get_fileName() return pos.fileName;

	public var lineNumber(get,never) : Int;
	inline function get_lineNumber() return pos.lineNumber;

	public var methodName(get,never) : String;
	inline function get_methodName() return pos.methodName;

	public var stackItems(default,null) : Array<StackItem>;

	//public function new( ?message : String, ?pos : PosInfos ) {
	public function new( ?message : String, ?stack : Array<StackItem>, ?pos : PosInfos ) {

		#if js
		super( message );
		#end
		this.message = message;
		this.pos = pos;

		var clName = Type.getClassName( Type.getClass(this) );
		if( clName.indexOf( '.' ) != -1 ) clName = clName.split('.').pop();
		this.name = clName;

		if( stack == null ) {
			stack = try CallStack.exceptionStack() catch(e:Dynamic) [];
			if( stack.length == 0 )
				stack = try CallStack.callStack() catch(e:Dynamic) [];
		}
		this.stackItems = stack;
	}

	public function toString() : String {
		var items = getExceptionStack();
		if( items.length == 0 ) items = getCallStack();
		return getSourcePosition() + ' : ' + message + CallStack.toString( items );
	}

	public inline function getCallStack() : Array<StackItem>
		return CallStack.callStack();

	public inline function getExceptionStack() : Array<StackItem>
		return CallStack.exceptionStack();

	public inline function getSourcePosition() : String
		return pos.fileName + ':' + pos.lineNumber;

	/*
	public inline function callStack() : String
		return CallStack.toString( CallStack.callStack() );

	public inline function exceptionStack() : String
		return CallStack.toString( CallStack.exceptionStack() );


	public inline function getSourcePosition() : String
		return pos.fileName + ':' + pos.lineNumber;
		*/

		/*
	public static inline function ofDynamic( err : Dynamic, ?pos : PosInfos ) : TError {
		return new TError( err+'', null, pos );
	}
	*/

}
