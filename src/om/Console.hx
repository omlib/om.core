package om;

class Console {

    public static var console(get,never) : Dynamic;
    inline static function get_console() : Dynamic {
        #if nodejs
        return js.Node.console;
        #elseif js
        return js.Browser.console;
        #else
        return null;
        #end
    }
}
