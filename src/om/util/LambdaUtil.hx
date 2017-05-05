package om.util;

class LambdaUtil {

    public static function first<T>( it : Iterable<Null<T>>, f : Null<T>->Bool ) : Null<T> {
		for( x in it ) if( f(x) ) return x;
		return null;
	}

}
