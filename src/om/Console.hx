package om;

typedef Console =
	#if sys
	om._sys.Console;
	#elseif js
		#if nodejs
		om._node.Console;
		#else
		om._web.Console;
		#end
	#end

/*
#if macro
//#
#elseif js
	#if nodejs
	import js.Node.process;
	import js.node.ChildProcess;
	import om.ANSI;
	#else
	import js.Browser.console;
	#end
#elseif sys
import om.ANSI;
#end

/**
    Crossplatform console utilities.

    haxe/js     => js.Browser.console
    haxe/node   => stdout
    haxe/sys    => stdout

    Define -D no_console to remove all calls to this class.

* /
@defines('no_console','Remove calls to om.Console')
class Console {

    #if (sys||nodejs)

    public static var noColors = false;

    public static var color_info = Color.blue;
    public static var color_debug = Color.yellow;
    public static var color_warn = Color.magenta;
    public static var color_error = Color.red;

    #end

    #if sys

    public static inline function print( str : String, ?color : Int ) {
        #if (!no_console&&!doc_gen)
        Sys.print( (noColors || color == null) ? str : ANSI.colorize( str, color ) );
        #end
    }
    public static inline function println( str : String, ?color : Int ) print( '$str\n', color );
    public static inline function clear() Sys.print( '\033c' ); //Sys.command( 'clear' );
    public static inline function ln() Sys.print( '\n' );

    public static inline function log( o : Dynamic ) println( Std.string(o) );
    public static inline function info( o : Dynamic ) println( Std.string(o), color_info );
    public static inline function debug( o : Dynamic ) println( Std.string(o), color_debug );
    public static inline function warn( o : Dynamic ) println( Std.string(o), color_warn );
    public static inline function error( o : Dynamic ) println( Std.string(o), color_error );

    #elseif nodejs

    static function __print( str : String, ?color : Int ) {
        #if (!no_console&&!doc_gen)
        if( !noColors && color != null ) str = ANSI.colorize( str, color );
        process.stdout.write( str );
        #end
    }

    public static inline function print( obj : Dynamic, ?color : Int ) __print( Std.string(obj), color );
    public static inline function println( obj : Dynamic, ?color : Int ) __print( Std.string(obj)+'\n', color );
    public static inline function clear() process.stdout.write( '\033c' );
    public static inline function ln() process.stdout.write( '\n' );

    public static inline function log( obj : Dynamic ) println( obj );
    public static inline function info( obj : Dynamic ) println( obj, color_info );
    public static inline function debug( obj : Dynamic ) println( obj, color_debug );
    public static inline function warn( obj : Dynamic ) println( obj, color_warn );
    public static inline function error( obj : Dynamic ) println( obj, color_error );

    #elseif js

    public static inline function print( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.log( obj ); #end }
    public static inline function println( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.log( obj ); #end }
	public static inline function clear() { #if (!no_console&&!doc_gen) console.clear(); #end }
    public static inline function ln() log( '' );

    public static inline function log( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.log( obj ); #end }
	public static inline function info( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.info( obj ); #end }
	public static inline function debug( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.debug( obj ); #end }
	public static inline function warn( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.warn( obj ); #end }
	public static inline function error( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.error( obj ); #end }

	public static inline function table( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.table( obj ); #end }

    //public static inline function trace( obj : Dynamic ) { #if (!no_console&&!doc_gen) untyped console.trace( obj ); #end }

    public static inline function assert( expression : Dynamic, obj : Dynamic ) { #if (!no_console&&!doc_gen) console.assert( expression, obj ); #end }
    public static inline function exception( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.exception( obj ); #end }

	public static inline function count( label : String ) { #if (!no_console&&!doc_gen) console.count( label ); #end }

	public static inline function dir( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.dir( obj ); #end }
	public static inline function dirxml( obj : Dynamic ) { #if (!no_console&&!doc_gen)  untyped console.dirxml( obj ); #end }

	public static inline function group( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.group( obj ); #end }
	public static inline function groupCollapsed( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.groupCollapsed( obj ); #end }
	public static inline function groupEnd() { #if (!no_console&&!doc_gen) console.groupEnd(); #end }

	public static inline function profile( label : String ) { #if (!no_console&&!doc_gen) console.profile( label ); #end }
	public static inline function profileEnd() { #if (!no_console&&!doc_gen) console.profileEnd(); #end }

	public static inline function time( label : String ) { #if (!no_console&&!doc_gen) console.time( label ); #end }
	public static inline function timeEnd( label : String ) { #if (!no_console&&!doc_gen) console.timeEnd( label ); #end }

	public static inline function timeline( label : String ) { #if (!no_console&&!doc_gen) untyped console.timeline( label ); #end }
	public static inline function timelineEnd( label : String ) { #if (!no_console&&!doc_gen)  untyped console.timelineEnd( label ); #end }
	public static inline function timeStamp( label : String ) { #if (!no_console&&!doc_gen)  untyped console.timeStamp( label ); #end }

    #end
}
*/
