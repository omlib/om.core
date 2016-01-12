package om.util;

class FlagUtil {

	public static function toInt( flags : Array<Int> ) : Int {
		var v = 0;
		for( f in flags ) v |= f;
		return v;
	}

}
