package om;

import js.Browser.navigator;

class System {

    public static var language(get,never) : String;

    static inline function get_language() : String {
		return untyped window.navigator.language;
	}

    public static function getOS() : String {
        var expr = ~/(Android|CrOS|iP[ao]d|iPhone|Linux|Mac OS|windows)/i;
        return expr.match( navigator.userAgent ) ? expr.matched(1) : "unknown";
    }

    public static function isMobile() : Bool {
        return ~/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.match( navigator.userAgent );
    }
}
