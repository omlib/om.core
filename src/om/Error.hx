package om;

import haxe.PosInfos;
import haxe.CallStack;

class Error
#if js extends js.Error #end
{
	public var pos(default,null) : PosInfos;
	public var items(default,null) : Array<StackItem>;

	#if !js
    public var message(default,null) : String;
    public var name(default,null) : String;
    #end

	public var fileName(get,null) : String;
	inline function get_fileName() return pos.fileName;

	public var lineNumber(get,null) : Int;
	inline function get_lineNumber() return pos.lineNumber;

	public var methodName(get,null) : Int;
	inline function get_methodName() return pos.lineNumber;

	public function new( ?message : String, ?pos : PosInfos ) {

		#if js
		super( message );
		#end
		this.message = message;
		this.pos = pos;

		var className = Type.getClassName( Type.getClass(this) );
		if( className.indexOf( '.' ) != -1 ) className = className.split('.').pop();
		this.name = className;

        items = try CallStack.exceptionStack() catch(e:Dynamic) [];
        if( items.length == 0 ) items = try CallStack.callStack() catch(e:Dynamic) [];
	}

	public function toString() : String
        return getPositionString() + ' : ' + message + getStackString();

	public function getPositionString() : String
	    return pos.fileName + ':' + pos.lineNumber;

	public function getStackString() : String
	    return CallStack.toString( items );
}
