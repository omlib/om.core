package om.util;

class DateUtil {

	public static function xTimeAgo( date : Date ) : String {
		var diff = ( Date.now().getTime() - date.getTime() ) / 1000;
		var day_diff = Math.floor( diff / 86400 );
		if( Math.isNaN( day_diff ) || day_diff < 0 || day_diff >= 31 )
			return null;
		return if( day_diff == 0 ) {
			if( diff < 60 ) "just now";
			else if( diff < 120 ) "1 minute ago";
			else if( diff < 3600 ) Math.floor( diff/60 ) + " minutes ago";
			else if( diff < 7200 ) "1 hour ago";
			else if( diff < 86400 ) Math.floor( diff/3600 )+" hours ago";
			else null;
		} else {
			if( day_diff == 1 ) "Yesterday";
			else if( day_diff < 7 ) day_diff+" days ago";
			else if( day_diff < 31 ) Math.ceil( day_diff/7)+" weeks ago";
			else null;
		}
	}
	
}
