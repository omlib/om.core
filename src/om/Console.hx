package om;

#if macro
//
#elseif nodejs
import js.Node.process;
import js.node.ChildProcess;
#elseif js
import js.Browser.console;
#end

#if (sys||nodejs)
import om.term.TermColor;
import om.term.TermColorTool;
#end

/**
    Console utilities.

    haxe/js     => js.Browser.console
    haxe/node   => process.stdout.write
    haxe/sys    => Sys.print
*/
class Console {

    #if (sys||nodejs)

    public static var noColors = false;

    public static var color_info = TermColor.blue;
    public static var color_debug = TermColor.yellow;
    public static var color_warn = TermColor.magenta;
    public static var color_error = TermColor.red;

    #end

    #if sys

    public static inline function clear() Sys.print( '\033c' ); //Sys.command( 'clear' );

    public static inline function print( str : String, ?color : Int ) {
        #if (!no_console&&!doc_gen)
        Sys.print( (noColors || color == null) ? str : TermColorTool.color( str, color ) );
        #end
    }
    public static inline function println( str : String, ?color : Int ) print( '$str\n', color );

    public static inline function log( o : Dynamic ) println( Std.string(o) );
    public static inline function info( o : Dynamic ) println( Std.string(o), color_info );
    public static inline function debug( o : Dynamic ) println( Std.string(o), color_debug );
    public static inline function warn( o : Dynamic ) println( Std.string(o), color_warn );
    public static inline function error( o : Dynamic ) println( Std.string(o), color_error );

    #elseif nodejs

    static inline function __print( str : String, ?color : Int ) {
        #if (!no_console&&!doc_gen)
        if( !noColors && color != null ) str = TermColorTool.color( str, color );
        process.stdout.write( str );
        #end
    }

    public static inline function clear() process.stdout.write( '\033c' );

    public static inline function print( obj : Dynamic, ?color : Int ) __print( Std.string(obj), color );
    public static inline function println( obj : Dynamic, ?color : Int ) __print( Std.string(obj)+'\n', color );

    public static inline function log( obj : Dynamic ) println( obj );
    public static inline function info( obj : Dynamic ) println( obj, color_info );
    public static inline function debug( obj : Dynamic ) println( obj, color_debug );
    public static inline function warn( obj : Dynamic ) println( obj, color_warn );
    public static inline function error( obj : Dynamic ) println( obj, color_error );

    #elseif js

	public static inline function clear() { #if (!no_console&&!doc_gen) console.clear(); #end }

    public static inline function print( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.log( obj ); #end }
    public static inline function println( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.log( obj ); #end }

    public static inline function log( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.log( obj ); #end }
	public static inline function info( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.info( obj ); #end }
	public static inline function debug( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.debug( obj ); #end }
	public static inline function warn( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.warn( obj ); #end }
	public static inline function error( obj : Dynamic ) { #if (!no_console&&!doc_gen) console.error( obj ); #end }

	public static inline function assert( expression : Dynamic, obj : Dynamic ) { #if (!no_console&&!doc_gen) console.assert( expression, obj ); #end }

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
