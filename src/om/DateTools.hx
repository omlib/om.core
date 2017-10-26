package om.util;

class DateTools {

	public static inline function format( d : Date, f : String ) : String
		return std.DateTools.format( d, f );

	public static inline function delta( d : Date, t : Float ) : Date
		return std.DateTools.delta( d, t );

	public static inline function getMonthDays( d : Date ) : Int
		return std.DateTools.getMonthDays( d );

	public static inline function seconds( n : Float ) : Float
		return std.DateTools.seconds( n );

	public static inline function minutes( n : Float ) : Float
		return std.DateTools.minutes( n );

	public static inline function hours( n : Float ) : Float
		return std.DateTools.hours( n );

	public static inline function days( n : Float ) : Float
		return std.DateTools.days( n );

	public static inline function parse( t : Float )
		return std.DateTools.parse( t );

	public static inline function make( o : { ms : Float, seconds : Int, minutes : Int, hours : Int, days : Int } ) : Float
		return std.DateTools.make( o );

	#if (js || flash || php || cpp || python)

	public static inline function makeUtc( year : Int, month : Int, day : Int, hour : Int, min : Int, sec : Int ) : Float
		return std.DateTools.makeUtc( year, month, day, hour, min, sec );

	#end

	/*
	public static inline function weeks( days : Float ) : Int {
		return Math.floor( Math.ceil( days / 7 ) );
	}

	public static inline function days( diff : Float ) : Int {
		return Math.floor( diff / 86400 );
	}

	public static inline function hours( diff : Float ) : Int {
		return Math.floor( diff / 3600 );
	}

	public static inline function minutes( diff : Float ) : Int {
		return Math.floor( diff / 60 );
	}
	*/

	/**
		Formats given date to:
		  - just now
		  - 1 minute ago
		  - 1+N minutes ago
		  - Yesterday
		  - 1+N days ago
		  - 1+N weeks ago
	*/
	public static function xTimeAgo( date : Date, ?now : Date ) : String {

		if( now == null ) now = Date.now();
		var b = now.getTime();
		var a = date.getTime();
		if( a > b )
			throw 'expected time value before $b'; //TODO tastes like shit

		var diff = (b - a) / 1000;
		var day_diff = days( diff );

		return if( Math.isNaN( day_diff ) || day_diff < 0 || day_diff >= 31 )
			null;
		else if( day_diff == 0 ) {
			if( diff < 60 ) "just now";
			else if( diff < 120 ) "1 minute ago";
			else if( diff < 3600 ) minutes( diff ) + " minutes ago";
			else if( diff < 7200 ) "1 hour ago";
			else if( diff < 86400 ) hours( diff )+" hours ago";
			else null;
		} else {
			if( day_diff == 1 ) "Yesterday";
			else if( day_diff < 7 ) day_diff+" days ago";
			else if( day_diff < 31 ) weeks( day_diff )+" weeks ago";
			else null;
		}
	}

}
