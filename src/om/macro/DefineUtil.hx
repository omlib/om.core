package om.macro;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;

/**
	Tools for accessing haxe build flags at compile time.
*/
class DefineUtil {

	public static inline function defined( key : String) : Bool
		return Context.defined( key );

	public static inline function definedValue<T>( key : String, ?def : T ) : T
        return defined( key ) ? cast Context.definedValue( key ) : def;

	public static inline function define( name : String, ?value : String ) : String {
	    Compiler.define( name, value );
		return value;
	}

}

#end
