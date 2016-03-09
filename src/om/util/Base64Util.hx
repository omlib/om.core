package om.util;

class Base64Util {

	public static function pad( str : String ) : String {
		return str + switch str.length % 3 {
		case 1: "==";
		case 2: "=";
		default: "";
		}
	}

	public static function unpad( str : String ) : String {
		while( str.charCodeAt( str.length-1 ) == "=".code )
			str = str.substr( 0, -1 );
		return str;
	}

}
