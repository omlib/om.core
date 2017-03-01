package om.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

class FieldTools {

	public static function isPublic( field : Field ) : Bool {
		for( access in field.access ) switch access {
			case APublic: return true;
			case _:
		}
		return false;
	}

	public static function isStatic( field : Field ) : Bool {
		for( access in field.access ) switch access {
			case AStatic: return true;
			case _:
		}
		return false;
	}

	public static function isMethod( field : Field ) : Bool {
		return switch field.kind {
			case FFun(_): true;
			case _: false;
		};
	}

	public static function isFieldInHierarchy( type : ClassType, name : String ) : Bool {
		if( name == "new" ) {
			if( type.constructor != null )
				return true;
		} else {
			if( hasClassField( type.fields.get(), name ) )
				return true;
		}
		var superClass = type.superClass;
		if( superClass == null )
			return false;
		return isFieldInHierarchy( superClass.t.get(), name );
	}

	public static function findField( fields : Array<Field>, name : String ) : Field {
		for( f in fields )
			if( f.name == name )
				return f;
		return null;
	}

	public static function findClassField( fields : Array<ClassField>, name : String ) : ClassField {
		for( f in fields )
			if( f.name == name )
				return f;
		return null;
	}

	public static inline function hasField( fields : Array<Field>, name : String ) : Bool
		return findField( fields, name ) != null;

	public static inline function hasClassField( fields : Array<ClassField>, name : String ) : Bool
		return findClassField( fields, name ) != null;

	public static function hasVarField( fields : Array<Field>, fieldName : String ) : Bool {
		for( f in fields )
			if( f.name == fieldName &&
				switch f.kind {
				case FVar(_,_): true;
				case _: false;
				})
				return true;
		    return false;
		}

	public static function hasMeta( field : Field, name : String ) : Bool {
	    if( field.meta == null )
			return false;
	    for( m in field.meta )
			if( m.name == name )
				return true;
	    return false;
	}

	public static function hasFunField( fields : Array<Field>, fieldName : String ) : Bool {
		for( field in fields )
			if( field.name == fieldName &&
				switch field.kind {
				case FFun(_): true;
				case _: false;
			})
			return true;
		return false;
	}

	public static function makePublic( fields : Array<Field>, name : String ) {
		var f = findField( fields, name );
		if( f == null )
			return;
    	makeFieldPublic( f );
	}

	public static function makeFieldPublic( field : Field ) : Field {
	    if( isPublic( field ) )
			return field;
		field.access.push( APublic );
		return field;
	}

	public static function makeVarsPublic( fields : Array<Field> ) {
		fields.map( function(f) switch f.kind {
			case FVar(_,_) if( !isPublic( f ) ): f.access.push( APublic );
			case _:
		});
	}

	public static function createVarField( name : String, type : ComplexType ) : Field {
    	return {
			name: name,
			kind: FVar(type,null),
			pos: Context.currentPos()
		};
	}

	public static function hasFunctionArguments( field : Field ) : Bool {
		return getFunctionArguments( field ).length > 0;
	}

	public static function getFunctionArguments( field : Field ) : Array<FunctionArg> {
		switch field.kind {
		case FFun(o): return o.args;
		case _: return null;
		}
	}

	public static function getVarAsFunctionArgs( fields : Array<Field> ) : Array<FunctionArg> {
		return cast fields
			.map(function(f) return switch f.kind {
				case FVar(t,_) if( !isStatic(f) ):
					{ name : f.name, type : t, opt : null, value : null }
				case _:
					null;
		}).filter( function(f) return f != null );
	}

	public static function createFunctionField( name : String, ?args : Array<FunctionArg>, ?ret : ComplexType, ?expr : Expr ) : Field {
    	return {
			name: name,
			access: [APublic],
			kind: FFun({
		        ret  : (null != ret) ? ret : macro : Void,
		        expr : (null != expr) ? expr : macro {},
		        args : (null != args) ? args : []
			}),
	      	pos: Context.currentPos()
	    };
	}

	public static function pushConstVar<T>( fields : Array<Field>, name : String, type : ComplexType, value : T ) : Array<Field> {
		fields.push({
    		access: [APublic,AStatic,AInline],
    		kind: FVar( type, macro $v{value} ),
			name: name,
    		pos: Context.currentPos()
    	});
		return fields;
	}

	public static function pushConstIntVar( fields : Array<Field>, name : String, value : Int ) : Array<Field> {
		return pushConstVar( fields, name, macro:Int, value );
	}

	public static function pushConstFloatVar( fields : Array<Field>, name : String, value : Float ) : Array<Field> {
		return pushConstVar( fields, name, macro:Float, value );
	}

	public static function pushConstStringVar( fields : Array<Field>, name : String, value : String ) : Array<Field> {
		return pushConstVar( fields, name, macro:String, value );
	}

	public static function appendExprToFunctionField( field : Field, expr : Expr ) {
		switch field.kind {
		case FFun(o):
			var exprs = [o.expr, expr];
			o.expr = macro $b{exprs};
		case _:
		}
	}

}

#end
