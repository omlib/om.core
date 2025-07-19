package om;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;

using om.macro.FieldTools;

class WorkerScript {
	static function build():Array<Field> {
		var fields = Context.getBuildFields();
		var pos = Context.currentPos();

		inline function error(msg:String)
			Context.fatalError(msg, pos);

		/*
			if( fields.hasFunField( 'main' ) )
				error( 'worker scripts cannot have main method' );
			if( fields.hasFunField( '__init__' ) )
				error( 'Class already has __init__ method' );
			if( !fields.hasFunField( 'onMessage' ) )
				error( 'missing [onMessage] method' );
		 */
		// trace(fields.hasFunField( 'onMessage' ) );

		if (fields.hasFunField('onMessage')) {
			var onMessage = fields.findField('onMessage');
			onMessage.meta.push({name: ':expose', params: [macro "onmessage"], pos: pos});
		}

		fields.push({
			name: 'self',
			access: [AStatic],
			kind: FProp("get", "never", macro :js.html.DedicatedWorkerGlobalScope),
			pos: pos
		});
		fields.push({
			name: 'get_self',
			access: [AStatic, AInline],
			kind: FFun({
				args: [],
				expr: macro return js.Syntax.code("self"),
				ret: macro :js.html.DedicatedWorkerGlobalScope
			}),
			pos: pos
		});

		// var cl = Context.getLocalClass().get();
		// var clPath = cl.pack.concat( [cl.name] ).join( '_' );
		// var js = 'self.onmessage=$clPath.onMessage';

		/*
			fields.push({
				name: '__init__',
				access: [APublic,AStatic,AInline],
				kind: FFun( { expr: macro untyped __js__($v{js}), args: [], ret: null } ),
				pos: pos
			});
		 */
		/*
			if( !fields.hasFunField( 'postMessage' ) ) {
				fields.push({
					name: 'postMessage',
					access: [APublic,AStatic],
					kind: FFun( {
						args: [
							{ name: 'message', type: macro:Dynamic },
							{ name: 'transfer', type: macro:Array<Dynamic>, opt: true }
						],
						expr: macro untyped __js__('self.postMessage(message,transfer)'),
						ret: macro:Void
					} ),
					//meta: [ { name: ':keep', pos: pos } ],
					pos: pos
				});
			}
		 */

		return fields;
	}
}
#else

/**
	Implement this interface to build a standalone worker script.

	```haxe
	class MyWorkerScript implements om.WorkerScript {
		static function onMessage( e : js.html.MessageEvent ) {
			trace( e );
			postMessage( 'howdi' );
		}
	}
	```
**/
@:autoBuild(om.WorkerScript.build())
@:keepSub
interface WorkerScript {}
#end
