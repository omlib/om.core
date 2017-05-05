package om.util;

class IterableUtil {

    public static function first<T>( it : Iterable<Null<T>>, f : Null<T>->Bool ) : Null<T> {
		for( x in it ) if( f(x) ) return x;
		return null;
	}

	public static function count<T>( i : Iterable<Null<T>> ) : Int {
		var n = 0;
		for( _ in i ) n++;
		return n;
	}
}
