package om;

using om.StringTools;

class IntTools {

	static var BASE = "0123456789abcdefghijklmnopqrstuvwxyz";

    static var pattern_parse = ~/^[ \t\r\n]*[+-]?(\d+|0x[0-9A-F]+)/i;

    public static inline function canParse( s : String ) : Bool
        return pattern_parse.match( s );

    public static function parse( s : String, ?base : Int ) : Null<Int> {

        #if js
        if( base == null )
            base = (s.substring( 0, 2 ) == "0x") ? 16 : 10;
        var v : Int = untyped __js__( "parseInt" )( s, base );
        return Math.isNaN( v ) ? null : v;

        #else
		if( base != null && (base < 2 || base > BASE.length) )
			return throw 'invalid base $base, it must be between 2 and ${BASE.length}';

	    s = s.trim().toLowerCase();

	    var sign = if( s.startsWith("+") ) {
			s = s.substring(1);
			1;
		} else if(s.startsWith("-")) {
			s = s.substring(1);
			-1;
		} else {
			1;
		};

	    if( s.length == 0 )
			return null;

	    if( s.startsWith('0x') ) {
			if(null != base && 16 != base)
	        	return null; // attempting at converting a hex using a different base
			base = 16;
			s = s.substring(2);
	    } else if(null == base) {
			base = 10;
	    }

	    var acc = 0;
	    try s.map( function(c) {
			var i = BASE.indexOf(c);
			if( i < 0 || i >= base) throw 'invalid';
			acc = (acc * base) + i;
			return null;
		}) catch(e : Dynamic) {};

	    return acc * sign;

        #end
    }

}
