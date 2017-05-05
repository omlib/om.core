package om;

@:enum abstract Control(String) from String to String {
	var up = "A";
	var down = "B";
	var forward = "C";
	var back = "D";
	var nextLine = "E";
	var previousLine = "F";
	var horizontalAbsolute = "G";
	var eraseData = "J";
	var eraseLine = "L";
	var scrollUp = "S";
	var scrollDown = "T";
	var savePosition = "s";
	var restorePosition = "u";
	var queryPosition = "6n";
	//var hide = "?25l";
	//var show = "?25h";
}

@:enum abstract Color(Int) from Int to Int {

    var black = 30;
    var red = 31;
    var green = 32;
    var yellow = 33;
    var blue = 34;
    var magenta = 35;
    var cyan = 36;
    var white = 37;

    var bright_black = 90;
    var bright_red = 91;
    var bright_green = 92;
    var bright_yellow = 93;
    var bright_blue = 94;
    var bright_magenta = 95;
    var bright_cyan = 96;
    var bright_white = 97;
}

@:enum abstract BackgroundColor(Int) from Int to Int {

    var black = 40;
    var red = 41;
    var green = 42;
    var yellow = 43;
    var blue = 44;
    var magenta = 45;
    var cyan = 46;
    var white = 47;

    var bright_black = 100;
    var bright_red = 101;
    var bright_green = 102;
    var bright_yellow = 103;
    var bright_blue = 104;
    var bright_magenta = 105;
    var bright_cyan = 106;
    var bright_white = 107;
}

/**
	SGR (Select Graphic Rendition)
*/
@:enum abstract Style(Int) from Int to Int {
	var bold = 1;
	var faint = 2;
	var italic = 3;
	var underline = 4;
	var blink_slow = 5;
	var blink_rapid = 6;
	var reverse = 7;
	var conceal = 8;
	var crossed_out = 9;
	//...
}

/*
class Style {
    public static var reset = [0,22];
    public static var bright = [1,22];
    public static var dim = [2,22];
    public static var italic = [3,23];
    public static var underline = [4,24];
    public static var blink = [5,25];
    public static var inverse = [7,27];
}
*/

class ANSI {

	public static inline var ESCAPE = '\x1B';
    public static inline var CSI = ESCAPE + '[';
	public static inline var SUFFIX = 'm'; // Colors only
	public static inline var BELL = '\x07';

	public static inline function black( str : String ) return colorize( str, Color.black );
    public static inline function red( str : String ) return colorize( str, Color.red );
    public static inline function green( str : String ) return colorize( str, Color.green );
    public static inline function yellow( str : String ) return colorize( str, Color.yellow );
    public static inline function blue( str : String ) return colorize( str, Color.blue );
    public static inline function magenta( str : String ) return colorize( str, Color.magenta );
    public static inline function cyan( str : String ) return colorize( str, Color.cyan );
    public static inline function white( str : String ) return colorize( str, Color.white );

	public static inline function bg_black( str : String ) return colorizeBackground( str, BackgroundColor.black );
    public static inline function bg_red( str : String ) return colorizeBackground( str, BackgroundColor.red );
    public static inline function bg_green( str : String ) return colorizeBackground( str, BackgroundColor.green );
    public static inline function bg_yellow( str : String ) return colorizeBackground( str, BackgroundColor.yellow );
    public static inline function bg_blue( str : String ) return colorizeBackground( str, BackgroundColor.blue );
    public static inline function bg_magenta( str : String ) return colorizeBackground( str, BackgroundColor.magenta );
    public static inline function bg_cyan( str : String ) return colorizeBackground( str, BackgroundColor.cyan );
    public static inline function bg_white( str : String ) return colorizeBackground( str, BackgroundColor.white );

	public static inline function colorize( str : String, color : Color, resetCode = 39 ) : String {
		return wrapColor( str, color, resetCode );
	}

	public static inline function colorizeBackground( str : String, color : BackgroundColor, resetCode = 49 ) : String {
		return wrapColor( str, color, resetCode );
	}

	public static function wrapColor( str : String, color : Int, ?resetCode : Int ) : String {
		var s = CSI + color + 'm' + str ;
		if( resetCode != null ) s += CSI + resetCode + 'm';
		return s;
	}

	#if sys

	public static function isSupported() : Bool {
	    if( Sys.systemName() == 'Windows' )
	        return false;
	    if( Sys.getEnv( 'COLORTERM' ) != null )
	        return true;
	    var term = Sys.getEnv( 'TERM' );
	    if( term == 'dumb' )
	        return false;
	    return ~/^screen|^xterm|^vt100|color|ansi|cygwin|linux/i.match( term );
	}

	#end
}
