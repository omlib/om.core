package om.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.File;

using haxe.macro.ExprTools;

/**
	Syntax-tolerant, position-aware json parser.

	See: http://nadako.tumblr.com/post/77106860013/using-haxe-macros-as-syntax-tolerant
**/
class Hxon {
	public static function readFile<T>(path:String, validate = false):T {
		var content = File.getContent(path);
		var pos = Context.makePosition({min: 0, max: 0, file: path});
		var e = Context.parseInlineString(content, pos);
		if (validate)
			validateExpr(e);
		return extractValue(e);
	}

	public static function validateExpr(e:Expr) {
		switch e.expr {
			case EConst(CInt(_) | CFloat(_) | CString(_) | CIdent("true" | "false" | "null")): // constants
			case EBlock([]): // empty object
			case EObjectDecl(fields):
				for (f in fields)
					validateExpr(f.expr);
			case EArrayDecl(exprs):
				for (e in exprs)
					validateExpr(e);
			default:
				throw new Error("Invalid JSON expression: " + e.toString(), e.pos);
		}
	}

	public static function extractValue(e:Expr):Dynamic {
		switch e.expr {
			case EConst(c):
				switch c {
					case CInt(s):
						var i = Std.parseInt(s);
						return (i != null) ? i : Std.parseFloat(s); // if the number exceeds standard int return as float
					case CFloat(s):
						return Std.parseFloat(s);
					case CString(s):
						return s;
					case CIdent("null"):
						return null;
					case CIdent("true"):
						return true;
					case CIdent("false"):
						return false;
					case CIdent(ident):
						// trace("!!!!"+ident+"##");
						return ident;
					default:
						return null;
				}
			// case EBinop(op):
			//    trace(op);
			case EBlock([]):
				return {};
			case EObjectDecl(fields):
				var obj = {};
				for (f in fields)
					Reflect.setField(obj, unquoteField(f.field), extractValue(f.expr));
				return obj;
			case EArrayDecl(exprs):
				return [for (e in exprs) extractValue(e)];
			// case EFunction(name,f):
			// trace(f);
			// return extractValue(f.expr);
			// case ECall(e,params):
			//    trace(e);
			case EField(e, field):
				switch e.expr {
					case EConst(c):
						switch c {
							case CIdent(i):
								var name = '$i.$field';
								// Compiler.addClassPath(i+'.'+field);
								Context.getModule(name);
								return name;
							default:
						}
					default:
				}

			default:
				trace("????????????", e);
				// return throw new Error( "Invalid JSON expression: " + e.toString(), e.pos );
				// return ExprTools.getValue( e );
		}
		throw new Error("Invalid JSON expression: " + e.toString(), e.pos);
	}

	static inline var QUOTE_PREFIX = "'";

	static function unquoteField(name:String):String {
		return (name.indexOf(QUOTE_PREFIX) == 0) ? name.substr(QUOTE_PREFIX.length) : name;
	}
}
#end
